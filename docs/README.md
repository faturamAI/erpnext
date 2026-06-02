# docs/ — Lokal Frappe & ERPNext dokümantasyon önbelleği

Resmi Frappe ve ERPNext dokümantasyonunun **internet bağımsız**, **IDE'den grep'lenebilir**, **konu bazlı düzenlenmiş** lokal markdown kopyası. ERPNext kodu yazarken sürekli ihtiyaç duyduğun referans.

İki aşamalı pipeline:
1. **`fetch-docs.sh`** — Resmi dokümanları indir + HTML'i markdown'a çevir (wget mirror + pup + pandoc)
2. **`organize-docs.sh`** — Markdown'ları konu bazlı klasörlere yerleştir + `[[Wiki-Link]]` syntax'ını standart link'e çevir + her klasöre `README.md` indeksi yaz

Tek komutla:
```bash
bash docs/organize-docs.sh
```
(Eksik kaynak varsa otomatik fetch eder, sonra organize.)

## Sonuç ağacı

```
docs/
  frappe/
    framework/        # docs.frappe.io/framework markdown ağacı (URL yapısı korunur)
    wiki/
      client-side-scripting/   migration/             testing/
      development/             installation/          (Home, _Sidebar, _Footer)
  erpnext/
    user/             # docs.frappe.io/erpnext markdown ağacı
    wiki/
      setup/          print-formats/   migration/    development/
      contribution/   testing/         releases/     modules/
      accounts/       stock/           community/    specs/
      misc/           agri-farm-erpnext/             (Home, _sidebar)
```

Her dizinde otomatik üretilmiş `README.md` indeksi: alt klasörler + dosya başlıkları + ilk-satır description.

## Kaynak / build artifacts

| Klasör | Ne işe yarar | gitignore? |
|---|---|---|
| `_raw_html/` | wget HTML mirror — pandoc'un girdisi (~350 MB - 2 GB, page-requisites'e bağlı) | ✅ evet |
| `github-wiki/{frappe,erpnext}/` | `fetch-docs.sh`'in indirdiği wiki git clone'ları (~9 MB) | ✅ evet |
| `frappe-framework/`, `erpnext-user/` | `fetch-docs.sh`'in ham pandoc çıktısı (organize öncesi) | ✅ evet |
| **`frappe/`, `erpnext/`** | **nihai organize markdown — repo'ya commit edilen** | ❌ hayır (tracked) |

`organize-docs.sh` ham çıktıyı `frappe/framework/` ve `erpnext/user/`'a taşıyıp wiki'leri konu klasörlerine kopyalar. Yukarıdaki ✅ işaretli klasörler **build cache**'tir; istediğin zaman silebilirsin (`bash docs/organize-docs.sh --clean`) veya `git clean -dxf docs/` ile dağıtabilirsin. `fetch-docs.sh + organize-docs.sh` her şeyi sıfırdan tekrar üretir.

## Kurulum (ilk seferde)

Gerekli araçlar:

```bash
# macOS
brew install wget pandoc pup git python3

# Debian / Ubuntu
sudo apt install -y wget pandoc git python3
# pup statik binary (apt'da yok):
wget -O /tmp/pup.zip https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_amd64.zip
unzip /tmp/pup.zip -d /tmp && sudo mv /tmp/pup /usr/local/bin/
# arm64 için linux_arm64.zip kullan
```

`organize-docs.sh` preflight'ında eksik araçları söyler.

## Çalıştırma

```bash
bash docs/organize-docs.sh             # eksik kaynakları fetch + organize (önerilen)
bash docs/organize-docs.sh --refresh   # zorla fetch (wget timestamp ile sadece değişeni)
bash docs/organize-docs.sh --clean     # sonunda _raw_html/'ı sil (yer aç)
```

Sadece fetch (organize yapmadan):
```bash
bash docs/fetch-docs.sh                # hepsi
bash docs/fetch-docs.sh framework      # sadece frappe framework
bash docs/fetch-docs.sh erpnext        # sadece erpnext user
bash docs/fetch-docs.sh wiki           # sadece github wiki'ler (saniyeler)
```

## Selector override

`fetch-docs.sh` HTML'den ana içeriği `pup` ile extract eder. Default selector auto-detect: `main` → `.from-markdown` → `.docs-content` → `article` → `#content`. Yetmezse env var:

```bash
CONTENT_SELECTOR='.my-custom-content' bash docs/fetch-docs.sh
```

## Reorganize detayları

`organize-docs.sh` adımları:

1. **Preflight** — pandoc/pup/wget/python3/git kontrolü
2. **Fetch (conditional)** — `_raw_html/` veya `github-wiki/` eksikse `fetch-docs.sh all` çalıştır
3. **v14 legacy at** — `framework/v14/` (eski sürüm, develop branch v17) tamamen silinir
4. **Namespace rename** — `frappe-framework/` → `frappe/framework/`, `erpnext-user/` → `erpnext/user/`
5. **Wiki reorganize** — `python3 scripts/reorganize_wiki.py` her wiki için flat dosyaları konu klasörlerine **kopyalar** (orijinal git clone dokunulmaz) ve `[[A|B]]`/`[[A]]` link syntax'ını standart relative markdown'a çevirir
6. **Index üret** — `python3 scripts/generate_indexes.py` her dizine `README.md` yazar (alt klasörler + dosyalar + ilk satır açıklamalar)
7. **(Opsiyonel) Clean** — `--clean` ile `_raw_html/` silinir

Konu klasörü kuralları (`scripts/wiki_topic_map.py`): ordered regex listesi, ilk eşleşen kazanır, eşleşmeyen `misc/`'e gider. Yeni dosya türleri eklenirse map güncellenir.

## Kullanım

**VS Code**: `Cmd/Ctrl + Shift + F` → "files to include" satırına `docs/` yaz → herhangi bir terimi (örn `frappe.db.get_value`, `Stock Reorder`) ara.

**Terminal**:
```bash
grep -rn "frappe.db.get_value" docs/frappe/framework/ | head
grep -rl "Sales Invoice" docs/erpnext/user/ | head
ls docs/erpnext/wiki/setup/                # konu bazlı browse
```

## Bilinen sınırlamalar

- **Tablolar**: Karmaşık tablolar (rowspan/colspan) bazen pandoc dönüşümünde bozulur — gerektiğinde online sayfaya göz at.
- **Çapraz linkler**: `frappe/framework/` içindeki sayfalar arası `<a href="...">` bağlantıları markdown'da `.html` uzantılı kalabilir — `organize-docs.sh` şu an bunu rewrite etmiyor.
- **Wiki link miss'leri**: Slug map'te bulunmayan `[[...]]` referansları olduğu gibi bırakılır + reorganize log'una warning düşer.
- **agri-farm-erpnext görselleri**: `[[assets/img/foo.png]]` syntax'ı (wiki-style image embed) standart markdown'a dönüştürülmüyor — bilinçli; bu klasör orijinal halinde korunuyor.
- **Video / live demo**: Embed olan içerikler markdown'da link olarak kalır.
- **Güncellik**: Otomatik cron yok — ayda bir manuel `bash docs/organize-docs.sh --refresh` yeterli.
- **Dil**: Sadece İngilizce (`/en/` path); diğer diller atlanır.

## Boyut

İlk tam çalıştırma sonrası gerçek değerler (ölçüm):

- `frappe/framework/`: ~7.3 MB markdown, 257 dosya (v14 atıldıktan sonra)
- `erpnext/user/`: ~25 MB markdown, 841 dosya
- `frappe/wiki/`: ~256 KB, 38 dosya (5 konu klasörü + 6 index)
- `erpnext/wiki/`: ~4.8 MB, 127 dosya (14 konu klasörü + 15 index)
- **Toplam tracked**: ~37 MB
- `_raw_html/` build cache: 350 MB - 2 GB (her zaman silinebilir)
