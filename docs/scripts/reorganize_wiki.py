"""
GitHub wiki dosyalarını flat root'tan konu klasörlerine KOPYALA,
sonra [[Wiki-Link]] syntax'ını standart markdown'a çevir.

Kullanım:
    python3 scripts/reorganize_wiki.py erpnext
    python3 scripts/reorganize_wiki.py frappe

Çalışma dizini: docs/ (script dizininin parent'ı).

KOPYA-tabanlı: github-wiki/{app}/ git clone'u dokunulmaz; çıktı erpnext/wiki/
veya frappe/wiki/ altına copy edilir. Re-run her seferinde topical klasörleri
sıfırdan kurar — eski misclassification artığı kalmaz.
İdempotent: aynı sonuç birden fazla çalıştırmada üretilir.
"""

from __future__ import annotations

import os
import re
import shutil
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from wiki_topic_map import SKIP_SUBDIRS, classify

# Bilinen konu klasörlerinin tüm seti — idempotency için temizlikte kullanılır.
KNOWN_FOLDERS = {
	"setup", "print-formats", "migration", "development", "contribution",
	"testing", "releases", "modules", "accounts", "stock", "community",
	"specs", "misc",
	"client-side-scripting", "installation",
}

WIKI_LINK_PIPED = re.compile(r"\[\[([^\[\]|]+)\|([^\[\]]+)\]\]")
WIKI_LINK_PLAIN = re.compile(r"\[\[([^\[\]|]+)\]\]")
FENCE_RE = re.compile(r"^```")


def slug_normalize(name: str) -> str:
	"""'Migrating to Version 13' → 'migrating-to-version-13' (filename eşlemesi için)."""
	name = name.strip()
	name = re.sub(r"\s+", "-", name)
	return name.lower()


def clear_topic_folders(wiki_target: Path) -> None:
	"""Hedef altındaki bilinen konu klasörlerini sil — temiz başlangıç için."""
	for folder in KNOWN_FOLDERS:
		d = wiki_target / folder
		if d.is_dir():
			shutil.rmtree(d)


def copy_files(wiki_source: Path, wiki_target: Path, app: str) -> dict[str, str]:
	"""
	Wiki source'taki tüm root .md dosyalarını topic-classify edip target'a kopyala.
	Special files (Home, _Sidebar, vb.) target root'una kopyalanır.
	agri-farm-erpnext/ gibi alt dizinler olduğu gibi kopyalanır.

	Returns: slug_normalized → new_relpath (wiki_target'a göreli)
	"""
	wiki_target.mkdir(parents=True, exist_ok=True)
	clear_topic_folders(wiki_target)

	slug_to_relpath: dict[str, str] = {}
	copied_topical = 0
	copied_special = 0

	# Root .md dosyaları
	for src in sorted(wiki_source.iterdir()):
		if not (src.is_file() and src.suffix == ".md"):
			continue
		filename = src.name
		folder = classify(filename, app)

		if folder is None:
			# Special — root'a kopya
			dest = wiki_target / filename
			shutil.copy2(str(src), str(dest))
			slug_to_relpath[slug_normalize(src.stem)] = filename
			copied_special += 1
		else:
			dest_dir = wiki_target / folder
			dest_dir.mkdir(parents=True, exist_ok=True)
			dest = dest_dir / filename
			shutil.copy2(str(src), str(dest))
			slug_to_relpath[slug_normalize(src.stem)] = f"{folder}/{filename}"
			copied_topical += 1

	# Alt dizinler (agri-farm-erpnext gibi) — toplu kopya
	for sub in SKIP_SUBDIRS:
		src = wiki_source / sub
		if src.is_dir():
			dest = wiki_target / sub
			if dest.exists():
				shutil.rmtree(dest)
			shutil.copytree(str(src), str(dest))

	print(f"  [{app}] kopyalandı: {copied_topical} topical, {copied_special} root-special")
	return slug_to_relpath


def discover_organized_files(wiki_target: Path) -> list[Path]:
	"""Link rewrite için: konu klasörleri + special root files (alt dizin SKIP_SUBDIRS hariç)."""
	out = []
	for folder in KNOWN_FOLDERS:
		d = wiki_target / folder
		if d.is_dir():
			for entry in d.iterdir():
				if entry.is_file() and entry.suffix == ".md":
					out.append(entry)
	for entry in wiki_target.iterdir():
		if entry.is_file() and entry.suffix == ".md":
			out.append(entry)
	return out


def split_code_blocks(text: str) -> list[tuple[bool, str]]:
	"""
	Markdown'ı (in_code, segment) parçalarına böl.
	Sadece fenced code (```) işlenir; inline code (`...`) bu pass'te ele alınmaz —
	kabul edilebilir, çünkü tek-satır inline'da `[[...]]` zaten neredeyse yok.
	"""
	parts: list[tuple[bool, str]] = []
	in_code = False
	buf: list[str] = []
	for line in text.splitlines(keepends=True):
		if FENCE_RE.match(line):
			if in_code:
				# Code block kapanıyor: fence'i de code segmentine dahil et
				buf.append(line)
				parts.append((True, "".join(buf)))
				buf = []
				in_code = False
			else:
				# Yeni code block: önceki text segmentini kaydet
				if buf:
					parts.append((False, "".join(buf)))
					buf = []
				buf.append(line)
				in_code = True
		else:
			buf.append(line)
	if buf:
		parts.append((in_code, "".join(buf)))
	return parts


def rewrite_links_in_segment(
	seg: str,
	source_relpath: str,
	slug_map: dict[str, str],
) -> tuple[str, int, int]:
	"""
	Bir text segment'inde [[A|B]] ve [[A]] linklerini standart markdown'a çevir.
	Returns: (rewritten_text, success_count, miss_count)
	"""
	source_dir = os.path.dirname(source_relpath)
	hits = 0
	misses = 0

	def resolve(slug: str) -> str | None:
		key = slug_normalize(slug)
		target = slug_map.get(key)
		if not target:
			return None
		if source_dir:
			return os.path.relpath(target, source_dir)
		return target

	def piped_repl(m: re.Match) -> str:
		nonlocal hits, misses
		display, slug = m.group(1).strip(), m.group(2).strip()
		rel = resolve(slug)
		if rel is None:
			misses += 1
			return m.group(0)
		hits += 1
		return f"[{display}]({rel})"

	def plain_repl(m: re.Match) -> str:
		nonlocal hits, misses
		slug = m.group(1).strip()
		# Code-ish içerik (JSON list literal vb): tırnak/virgül/backslash → atla
		if re.search(r'[",\\]', slug):
			return m.group(0)
		rel = resolve(slug)
		if rel is None:
			misses += 1
			return m.group(0)
		hits += 1
		return f"[{slug}]({rel})"

	seg = WIKI_LINK_PIPED.sub(piped_repl, seg)
	seg = WIKI_LINK_PLAIN.sub(plain_repl, seg)
	return seg, hits, misses


def rewrite_links(wiki_target: Path, slug_map: dict[str, str]) -> tuple[int, int]:
	total_hits = 0
	total_misses = 0
	for f in discover_organized_files(wiki_target):
		try:
			text = f.read_text(encoding="utf-8")
		except UnicodeDecodeError:
			continue
		rel = f.relative_to(wiki_target).as_posix()
		parts = split_code_blocks(text)
		new_parts: list[str] = []
		for in_code, seg in parts:
			if in_code:
				new_parts.append(seg)
			else:
				rewritten, hits, misses = rewrite_links_in_segment(seg, rel, slug_map)
				new_parts.append(rewritten)
				total_hits += hits
				total_misses += misses
		new_text = "".join(new_parts)
		if new_text != text:
			f.write_text(new_text, encoding="utf-8")
	return total_hits, total_misses


def main() -> None:
	if len(sys.argv) != 2 or sys.argv[1] not in ("frappe", "erpnext"):
		print("kullanım: reorganize_wiki.py {frappe|erpnext}", file=sys.stderr)
		sys.exit(2)
	app = sys.argv[1]

	docs_root = Path(__file__).resolve().parent.parent
	source = docs_root / "github-wiki" / app
	target = docs_root / app / "wiki"

	if not source.is_dir():
		print(f"  [{app}] kaynak yok: {source} — atlanıyor", file=sys.stderr)
		return

	print(f"  [{app}] reorganize: {source} → {target}")
	slug_map = copy_files(source, target, app)
	hits, misses = rewrite_links(target, slug_map)
	print(f"  [{app}] link rewrite: {hits} başarılı, {misses} eşleşmedi (slug map'te yok)")


if __name__ == "__main__":
	main()
