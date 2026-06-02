"""
docs/frappe ve docs/erpnext ağaçlarını gez, her dizine README.md (index) yaz.

İçerik:
  # <Title-Case dizin adı>

  ## Subdirectories
  - [name](name/) — first-line description

  ## Files
  - [Title](file.md) — first non-empty line of file (≤120 char)

İdempotent: mevcut README.md overwrite edilir. Hidden, _-prefixed ve special
dosyalar (Home.md, _Sidebar.md, _Footer.md, _sidebar.md) listelenmez ama dosya
olarak silinmez.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

EXCLUDE_FILES = {"README.md", "Home.md", "_Sidebar.md", "_sidebar.md", "_Footer.md"}
EXCLUDE_DIRS = {".git", "node_modules", "_raw_html", "scripts", "github-wiki"}

H1_RE = re.compile(r"^#\s+(.+?)\s*$", re.M)
TRUNCATE = 120


def title_case_folder(name: str) -> str:
	"""'print-formats' → 'Print Formats', 'user' → 'User'"""
	return " ".join(w.capitalize() for w in re.split(r"[-_]", name))


def first_description(path: Path) -> str:
	"""
	Dosyanın ilk H1'i (yoksa ilk non-empty paragraph satırı) — kısaltılmış.
	"""
	try:
		text = path.read_text(encoding="utf-8", errors="ignore")
	except OSError:
		return ""
	m = H1_RE.search(text)
	if m:
		desc = m.group(1).strip()
	else:
		# İlk non-empty, non-frontmatter, non-heading-marker satır
		desc = ""
		for line in text.splitlines():
			s = line.strip()
			if not s or s.startswith("---") or s.startswith("#"):
				continue
			# Markdown vurguları temizle
			s = re.sub(r"[*_`]", "", s)
			desc = s
			break
	desc = re.sub(r"\s+", " ", desc).strip()
	if len(desc) > TRUNCATE:
		desc = desc[: TRUNCATE - 1].rstrip() + "…"
	return desc


def file_title(path: Path) -> str:
	"""Önce H1, yoksa dash→space + Title-Case stem."""
	try:
		text = path.read_text(encoding="utf-8", errors="ignore")
	except OSError:
		return path.stem
	m = H1_RE.search(text)
	if m:
		return m.group(1).strip()
	return re.sub(r"[-_]", " ", path.stem)


def list_subdirs(d: Path) -> list[Path]:
	out = []
	for entry in sorted(d.iterdir()):
		if entry.is_dir() and entry.name not in EXCLUDE_DIRS and not entry.name.startswith("."):
			out.append(entry)
	return out


def list_md_files(d: Path) -> list[Path]:
	out = []
	for entry in sorted(d.iterdir()):
		if entry.is_file() and entry.suffix == ".md" and entry.name not in EXCLUDE_FILES:
			out.append(entry)
	return out


def write_readme(d: Path, depth: int = 0) -> None:
	"""Her dizine README.md yaz. Recursive."""
	subdirs = list_subdirs(d)
	files = list_md_files(d)

	# Recurse önce
	for sub in subdirs:
		write_readme(sub, depth + 1)

	lines: list[str] = []
	title = title_case_folder(d.name) if depth > 0 else d.name.upper()
	lines.append(f"# {title}\n")
	lines.append("")

	# Üst seviye dizin için intro paragrafı
	if depth == 0:
		lines.append(f"Bu klasör, **{d.name}** dokümantasyon ağacının indeksidir. Aşağıdaki klasör/dosyalar otomatik üretildi (`bash docs/organize-docs.sh`).")
		lines.append("")

	if subdirs:
		lines.append("## Klasörler")
		lines.append("")
		for sub in subdirs:
			# Alt klasörün README'sinden description çıkar
			sub_readme = sub / "README.md"
			desc = first_description(sub_readme) if sub_readme.exists() else ""
			n_files = sum(1 for _ in sub.rglob("*.md") if _.name not in EXCLUDE_FILES)
			suffix = f" — {desc}" if desc and desc.lower() != title_case_folder(sub.name).lower() else ""
			lines.append(f"- [{title_case_folder(sub.name)}/]({sub.name}/) ({n_files} dosya){suffix}")
		lines.append("")

	if files:
		lines.append("## Dosyalar")
		lines.append("")
		for f in files:
			t = file_title(f)
			desc = first_description(f)
			# Title aynısı veya büyük benzerlikteyse description tekrar etmesin
			if desc.lower().startswith(t.lower()[:30]) or t.lower() in desc.lower():
				lines.append(f"- [{t}]({f.name})")
			else:
				suffix = f" — {desc}" if desc else ""
				lines.append(f"- [{t}]({f.name}){suffix}")
		lines.append("")

	if not subdirs and not files:
		lines.append("_(boş)_")
		lines.append("")

	(d / "README.md").write_text("\n".join(lines), encoding="utf-8")


def main() -> None:
	docs_root = Path(__file__).resolve().parent.parent
	roots = [docs_root / "frappe", docs_root / "erpnext"]
	wrote = 0
	for root in roots:
		if root.is_dir():
			write_readme(root, depth=0)
			wrote += sum(1 for _ in root.rglob("README.md"))
	print(f"  README.md yazıldı: {wrote} dizinde (frappe + erpnext ağacı)")


if __name__ == "__main__":
	main()
