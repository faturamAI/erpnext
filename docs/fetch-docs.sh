#!/usr/bin/env bash
#
# docs/fetch-docs.sh — Resmi Frappe & ERPNext dokümantasyonunu lokal markdown'a çek.
#
# Üretir:
#   docs/frappe-framework/   ← docs.frappe.io/framework  (HTML mirror + pandoc)
#   docs/erpnext-user/       ← docs.frappe.io/erpnext    (HTML mirror + pandoc)
#   docs/github-wiki/{frappe,erpnext}/  ← github.com/frappe/{frappe,erpnext}.wiki
#
# İdempotent: tekrar çalıştırınca wget timestamp ile sadece değişeni çeker.
#
# Kullanım:
#   bash docs/fetch-docs.sh                # hepsini çek
#   bash docs/fetch-docs.sh framework      # sadece frappe framework
#   bash docs/fetch-docs.sh erpnext        # sadece erpnext user docs
#   bash docs/fetch-docs.sh wiki           # sadece github wiki'leri
#   CONTENT_SELECTOR=main bash docs/fetch-docs.sh   # pup CSS selector override

set -euo pipefail

# ---------------------------------------------------------------------------
# Yollar (script repo kökünde docs/ altında çalışır)
# ---------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RAW_DIR="$SCRIPT_DIR/_raw_html"
FW_OUT="$SCRIPT_DIR/frappe-framework"
EN_OUT="$SCRIPT_DIR/erpnext-user"
WIKI_OUT="$SCRIPT_DIR/github-wiki"
FW_RAW="$RAW_DIR/frappe-framework"
EN_RAW="$RAW_DIR/erpnext-user"

CONTENT_SELECTOR="${CONTENT_SELECTOR:-}"   # boşsa auto-detect

log()  { printf "\033[1;34m[%s]\033[0m %s\n" "$(date +%H:%M:%S)" "$*"; }
warn() { printf "\033[1;33m[%s] WARN:\033[0m %s\n" "$(date +%H:%M:%S)" "$*"; }
die()  { printf "\033[1;31m[%s] ERROR:\033[0m %s\n" "$(date +%H:%M:%S)" "$*" >&2; exit 1; }

# ---------------------------------------------------------------------------
# Preflight (target'a göre koşullu — wiki için sadece git, html mirror için hepsi)
# ---------------------------------------------------------------------------
preflight() {
  local target="$1"
  local needed=()
  case "$target" in
    wiki)                       needed=(git) ;;
    framework|erpnext|all)      needed=(wget pandoc pup git) ;;
    *)                          needed=(git) ;;
  esac

  local missing=0
  for cmd in "${needed[@]}"; do
    if command -v "$cmd" >/dev/null 2>&1; then
      log "$cmd OK ($(command -v "$cmd"))"
    else
      warn "$cmd YOK"
      missing=1
    fi
  done

  if [ "$missing" -eq 1 ]; then
    cat <<EOF >&2

Eksik araç(lar) var. Kurulum:

  macOS:    brew install wget pandoc pup git
  Debian:   sudo apt install -y wget pandoc git
            # pup için: https://github.com/ericchiang/pup/releases  (statik binary)
            #   wget -O /tmp/pup.zip https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_arm64.zip
            #   unzip /tmp/pup.zip -d /tmp && sudo mv /tmp/pup /usr/local/bin/

EOF
    die "preflight başarısız"
  fi
}

# ---------------------------------------------------------------------------
# GitHub Wiki klonla / pull
# ---------------------------------------------------------------------------
fetch_wiki() {
  mkdir -p "$WIKI_OUT"
  for app in frappe erpnext; do
    local target="$WIKI_OUT/$app"
    local url="https://github.com/frappe/${app}.wiki.git"
    if [ -d "$target/.git" ]; then
      log "wiki/$app: pull"
      (cd "$target" && git pull --quiet --ff-only) || warn "wiki/$app pull başarısız"
    else
      log "wiki/$app: clone $url"
      git clone --depth 1 "$url" "$target" 2>&1 | sed 's/^/  /' \
        || warn "wiki/$app clone başarısız (repo wiki boş olabilir)"
    fi
  done
}

# ---------------------------------------------------------------------------
# Wget mirror (path-prefix bazlı)
# ---------------------------------------------------------------------------
mirror_path() {
  local path="$1"      # /framework veya /erpnext
  local out_dir="$2"
  mkdir -p "$out_dir"
  log "wget mirror: docs.frappe.io${path}/ → $out_dir"
  # --no-host-directories + -nH → host adı klasörlere yansımaz
  # --include-directories → sadece bu path-prefix'ten dosya çek
  wget --quiet --show-progress \
       --mirror --adjust-extension --convert-links --page-requisites \
       --no-parent --no-host-directories \
       --domains=docs.frappe.io \
       --include-directories="$path" \
       --restrict-file-names=unix \
       --reject='*.zip,*.tar.gz' \
       --user-agent='Mozilla/5.0 (compatible; offline-docs-mirror)' \
       -P "$out_dir" \
       "https://docs.frappe.io${path}/" 2>&1 | sed 's/^/  /' || true
}

# ---------------------------------------------------------------------------
# CSS selector auto-detect
# Frappe Wiki app'in render edilen sayfasındaki ana içerik selector'ünü bul.
# Sırasıyla dene, ilk bulunanı kullan.
# ---------------------------------------------------------------------------
auto_detect_selector() {
  local sample_html="$1"
  [ -f "$sample_html" ] || { echo ""; return; }
  for sel in 'main' '.from-markdown' '.docs-content' 'article' '#content'; do
    local len
    len=$(pup "$sel text{}" < "$sample_html" 2>/dev/null | wc -c | tr -d ' ')
    if [ "${len:-0}" -gt 500 ]; then
      echo "$sel"
      return
    fi
  done
  echo ""
}

# ---------------------------------------------------------------------------
# HTML → Markdown dönüş (pup ile content extract, pandoc ile MD)
# ---------------------------------------------------------------------------
htmls_to_markdown() {
  local raw_dir="$1"
  local out_dir="$2"
  local label="$3"

  [ -d "$raw_dir" ] || { warn "$raw_dir yok, $label dönüşümü atlanıyor"; return; }

  # Selector belirle (env override, yoksa auto-detect, yoksa default 'main')
  local selector="$CONTENT_SELECTOR"
  if [ -z "$selector" ]; then
    local sample
    sample=$(find "$raw_dir" -name "*.html" | head -1)
    if [ -n "$sample" ]; then
      selector=$(auto_detect_selector "$sample")
    fi
  fi
  selector="${selector:-main}"
  log "$label: pandoc dönüşümü (selector='$selector')"

  mkdir -p "$out_dir"
  local count=0
  while IFS= read -r html; do
    local rel="${html#$raw_dir/}"
    local out="$out_dir/${rel%.html}.md"
    mkdir -p "$(dirname "$out")"
    # pup ile main content extract → pandoc ile MD; sessiz hata toleransı
    if pup "$selector" < "$html" 2>/dev/null \
       | pandoc -f html -t gfm --wrap=none --markdown-headings=atx 2>/dev/null \
       > "$out.tmp"; then
      mv "$out.tmp" "$out"
      count=$((count + 1))
    else
      rm -f "$out.tmp"
      warn "  dönüştürülemedi: $rel"
    fi
  done < <(find "$raw_dir" -name "*.html")
  log "$label: $count markdown dosyası üretildi"
}

# ---------------------------------------------------------------------------
# Asset (resim) kopyalama — wget --page-requisites resimleri zaten çekti,
# raw'dan output'a olduğu gibi kopyala (sadece görsel uzantılar)
# ---------------------------------------------------------------------------
copy_assets() {
  local raw_dir="$1"
  local out_dir="$2"
  [ -d "$raw_dir" ] || return
  while IFS= read -r f; do
    local rel="${f#$raw_dir/}"
    local target="$out_dir/$rel"
    mkdir -p "$(dirname "$target")"
    cp -p "$f" "$target"
  done < <(find "$raw_dir" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.gif" -o -name "*.svg" -o -name "*.webp" \))
}

# ---------------------------------------------------------------------------
# Özet
# ---------------------------------------------------------------------------
summarize() {
  echo
  echo "=================================================="
  echo "ÖZET"
  echo "=================================================="
  for d in "$FW_OUT" "$EN_OUT" "$WIKI_OUT/frappe" "$WIKI_OUT/erpnext"; do
    if [ -d "$d" ]; then
      local n
      n=$(find "$d" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
      local sz
      sz=$(du -sh "$d" 2>/dev/null | awk '{print $1}')
      printf "  %-50s  %5s md  %6s\n" "$d" "$n" "$sz"
    fi
  done
  echo
  echo "IDE search: docs/ klasörü içinde 'Find in Folder'."
  echo "Güncelleme: tekrar 'bash docs/fetch-docs.sh' (idempotent)."
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
main() {
  local target="${1:-all}"
  preflight "$target"

  case "$target" in
    all|wiki)
      fetch_wiki
      ;;
  esac

  case "$target" in
    all|framework)
      mirror_path /framework "$FW_RAW"
      htmls_to_markdown "$FW_RAW" "$FW_OUT" "frappe-framework"
      copy_assets "$FW_RAW" "$FW_OUT"
      ;;
  esac

  case "$target" in
    all|erpnext)
      mirror_path /erpnext "$EN_RAW"
      htmls_to_markdown "$EN_RAW" "$EN_OUT" "erpnext-user"
      copy_assets "$EN_RAW" "$EN_OUT"
      ;;
  esac

  case "$target" in
    all|wiki|framework|erpnext) ;;
    *) die "geçersiz hedef: $target  (kullan: all|framework|erpnext|wiki)" ;;
  esac

  summarize
}

main "$@"
