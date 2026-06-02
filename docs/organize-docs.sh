#!/usr/bin/env bash
#
# docs/organize-docs.sh — Dağınık docs/ ağacını topical .md yapısına dönüştürür.
#
# Yapar:
#   1. Preflight (pandoc, pup, wget, python3, git)
#   2. Kaynaklar eksikse fetch-docs.sh ile çek (HTML mirror + wiki clone + pandoc)
#   3. Frappe Framework v14 legacy çıktısını sil (deprecated)
#   4. frappe-framework/ → frappe/framework/, erpnext-user/ → erpnext/user/  (rename)
#   5. github-wiki/{frappe,erpnext}/ → {frappe,erpnext}/wiki/<topic>/  (Python helper ile)
#   6. Her dizine README.md (auto-index)
#   7. (opsiyonel --clean) _raw_html/ build artifact'ı sil
#
# İdempotent: tekrar çalıştırma no-op (en fazla refresh).
#
# Kullanım:
#   bash docs/organize-docs.sh             # eksik kaynakları fetch + organize
#   bash docs/organize-docs.sh --refresh   # zorla fetch (wget timestamp ile fark)
#   bash docs/organize-docs.sh --clean     # sonunda _raw_html/'ı sil

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RAW_DIR="$SCRIPT_DIR/_raw_html"
FW_OUT_OLD="$SCRIPT_DIR/frappe-framework"      # fetch-docs.sh'in default çıktısı
EN_OUT_OLD="$SCRIPT_DIR/erpnext-user"          # fetch-docs.sh'in default çıktısı
FRAPPE_NS="$SCRIPT_DIR/frappe"
ERPNEXT_NS="$SCRIPT_DIR/erpnext"
WIKI_DIR="$SCRIPT_DIR/github-wiki"

REFRESH=0
CLEAN=0
for arg in "$@"; do
  case "$arg" in
    --refresh) REFRESH=1 ;;
    --clean)   CLEAN=1   ;;
    -h|--help)
      sed -n '2,20p' "${BASH_SOURCE[0]}"; exit 0
      ;;
    *) echo "bilinmeyen flag: $arg" >&2; exit 2 ;;
  esac
done

log()  { printf "\033[1;34m[%s]\033[0m %s\n" "$(date +%H:%M:%S)" "$*"; }
warn() { printf "\033[1;33m[%s] WARN:\033[0m %s\n" "$(date +%H:%M:%S)" "$*"; }
die()  { printf "\033[1;31m[%s] ERROR:\033[0m %s\n" "$(date +%H:%M:%S)" "$*" >&2; exit 1; }

# ---------------------------------------------------------------------------
# 1. Preflight
# ---------------------------------------------------------------------------
log "1) preflight: pandoc, pup, wget, python3, git"
missing=0
for cmd in pandoc pup wget python3 git; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    warn "  $cmd YOK"
    missing=1
  fi
done
if [ "$missing" -eq 1 ]; then
  cat <<EOF >&2

Eksik araç(lar) var. Kurulum:
  macOS:    brew install wget pandoc pup git python3
  Debian:   sudo apt install -y wget pandoc git python3
            # pup için statik binary:
            #   wget -O /tmp/pup.zip https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_amd64.zip
            #   unzip /tmp/pup.zip -d /tmp && sudo mv /tmp/pup /usr/local/bin/

EOF
  die "preflight başarısız"
fi

# ---------------------------------------------------------------------------
# 2. Fetch (conditional)
# ---------------------------------------------------------------------------
need_fetch=0
if [ "$REFRESH" -eq 1 ]; then
  need_fetch=1
elif [ ! -d "$RAW_DIR/erpnext-user" ] || [ ! -d "$RAW_DIR/frappe-framework" ]; then
  log "  HTML mirror eksik → fetch tetikleniyor"
  need_fetch=1
elif [ ! -d "$WIKI_DIR/frappe" ] || [ ! -d "$WIKI_DIR/erpnext" ]; then
  log "  github-wiki eksik → fetch tetikleniyor"
  need_fetch=1
fi

if [ "$need_fetch" -eq 1 ]; then
  log "2) fetch-docs.sh all  (wget mirror + wiki clone + pandoc — ilk kez ~10-15 dk)"
  bash "$SCRIPT_DIR/fetch-docs.sh" all
else
  log "2) fetch atlandı (kaynaklar mevcut, --refresh ile zorla)"
fi

# ---------------------------------------------------------------------------
# 3. v14 legacy frappe framework docs'u sil
# ---------------------------------------------------------------------------
log "3) v14 legacy framework docs siliniyor"
rm -rf "$FW_OUT_OLD/framework/v14"
rm -rf "$RAW_DIR/frappe-framework/framework/v14"
rm -rf "$FRAPPE_NS/framework/framework/v14"

# ---------------------------------------------------------------------------
# 4. Namespace rename: frappe-framework/ → frappe/framework/, erpnext-user/ → erpnext/user/
#    İdempotent: yeni varsa eskinin içeriğini merge eder.
# ---------------------------------------------------------------------------
log "4) namespace rename: frappe-framework/ → frappe/framework/, erpnext-user/ → erpnext/user/"

merge_or_move() {
  local src="$1"     # eski path (örn frappe-framework)
  local dst="$2"     # yeni path (örn frappe/framework)
  if [ ! -d "$src" ]; then
    return
  fi
  mkdir -p "$(dirname "$dst")"
  if [ -d "$dst" ]; then
    # Yeni hedef zaten var: src içeriğini içine merge et, src'yi sil
    log "  merge: $src/ → $dst/  (rsync)"
    if command -v rsync >/dev/null 2>&1; then
      rsync -a --remove-source-files "$src/" "$dst/"
      find "$src" -type d -empty -delete 2>/dev/null || true
    else
      # rsync yoksa cp+rm
      (cd "$src" && find . -type f) | while read -r f; do
        local target_file="$dst/${f#./}"
        mkdir -p "$(dirname "$target_file")"
        mv "$src/${f#./}" "$target_file"
      done
      find "$src" -type d -empty -delete 2>/dev/null || true
    fi
  else
    log "  rename: $src/ → $dst/"
    mv "$src" "$dst"
  fi
}

merge_or_move "$FW_OUT_OLD" "$FRAPPE_NS/framework"
merge_or_move "$EN_OUT_OLD" "$ERPNEXT_NS/user"

# ---------------------------------------------------------------------------
# 4b. Wget URL prefix yüzünden çift nesting var: frappe/framework/framework/...
#     ve erpnext/user/erpnext/... — iç katmanı yukarı çıkar, dış katmanı sil.
# ---------------------------------------------------------------------------
flatten_double_nesting() {
  local outer="$1"   # örn frappe/framework
  local inner_name  # örn framework veya erpnext
  inner_name=$(basename "$outer")
  # ERPNext için outer "user" ama içerik "erpnext" altında
  if [ "$inner_name" = "user" ]; then
    inner_name="erpnext"
  fi
  local inner="$outer/$inner_name"
  if [ -d "$inner" ]; then
    log "  flatten: $inner/* → $outer/  (redundant URL prefix temizleniyor)"
    # Mevcut README.md'yi koru — flatten sonrası tekrar üretilecek
    rm -f "$outer/README.md"
    # İç katmandaki her şeyi outer'a taşı
    if command -v rsync >/dev/null 2>&1; then
      rsync -a --remove-source-files "$inner/" "$outer/"
      find "$inner" -type d -empty -delete 2>/dev/null || true
      rmdir "$inner" 2>/dev/null || true
    else
      (cd "$inner" && find . -mindepth 1 -maxdepth 1) | while read -r f; do
        mv "$inner/${f#./}" "$outer/${f#./}"
      done
      rmdir "$inner" 2>/dev/null || true
    fi
  fi
}

flatten_double_nesting "$FRAPPE_NS/framework"
flatten_double_nesting "$ERPNEXT_NS/user"

# ---------------------------------------------------------------------------
# 5. Wiki reorganize (Python helper)
# ---------------------------------------------------------------------------
log "5) wiki reorganize: github-wiki/{frappe,erpnext}/ → {frappe,erpnext}/wiki/<topic>/"
python3 "$SCRIPT_DIR/scripts/reorganize_wiki.py" frappe
python3 "$SCRIPT_DIR/scripts/reorganize_wiki.py" erpnext

# ---------------------------------------------------------------------------
# 6. Index üret (her dizine README.md)
# ---------------------------------------------------------------------------
log "6) index README.md üretiliyor (frappe + erpnext ağaçları)"
python3 "$SCRIPT_DIR/scripts/generate_indexes.py"

# ---------------------------------------------------------------------------
# 7. Cleanup (opsiyonel)
# ---------------------------------------------------------------------------
if [ "$CLEAN" -eq 1 ]; then
  log "7) --clean: _raw_html/ siliniyor"
  rm -rf "$RAW_DIR"
else
  log "7) cleanup atlandı (--clean ile _raw_html/'ı silebilirsin)"
fi

# ---------------------------------------------------------------------------
# Özet
# ---------------------------------------------------------------------------
echo
echo "=================================================="
echo "ÖZET"
echo "=================================================="
for d in "$FRAPPE_NS/framework" "$FRAPPE_NS/wiki" "$ERPNEXT_NS/user" "$ERPNEXT_NS/wiki"; do
  if [ -d "$d" ]; then
    n=$(find "$d" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
    sz=$(du -sh "$d" 2>/dev/null | awk '{print $1}')
    rel="${d#$SCRIPT_DIR/}"
    printf "  %-40s  %5s md  %6s\n" "$rel" "$n" "$sz"
  fi
done
echo
if command -v tree >/dev/null 2>&1; then
  tree -L 3 -d "$SCRIPT_DIR/frappe" "$SCRIPT_DIR/erpnext" 2>/dev/null | head -50
else
  find "$SCRIPT_DIR/frappe" "$SCRIPT_DIR/erpnext" -maxdepth 3 -type d 2>/dev/null | sort | head -50
fi
echo
log "Bitti. Düzenli markdown ağacı: docs/frappe/ ve docs/erpnext/"
