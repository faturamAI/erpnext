"""
GitHub wiki dosyalarını konu klasörlerine eşleyen kurallar.

Her kural: (regex, folder). Filename üzerinde sırayla denenir, ilk eşleşen kazanır.
Hiçbir kurala uymayan dosya 'misc/' altına gider.

Special files (Home.md, _Sidebar.md, _sidebar.md, _Footer.md) hiç taşınmaz —
wiki kökünde kalır. agri-farm-erpnext/ alt klasörü dokunulmaz.
"""

import re

SPECIAL_FILES = {"Home.md", "_Sidebar.md", "_sidebar.md", "_Footer.md"}
SKIP_SUBDIRS = {"agri-farm-erpnext"}

# Sıra önemli — daha spesifik kurallar üstte. İlk match kazanır.
ERPNEXT_RULES = [
	# Print formats — özel olduğundan üstte
	(re.compile(r"Print[-_]?Format|Standard[-_]Print|Standard[-_]With[-_]Columns|Legacy[-_]Print", re.I), "print-formats"),

	# Setup / installation / deployment (boşluklu "Setting up Backup Manager" gibi adları da yakala)
	(re.compile(r"^(Install|Apache|MySQL|WSGI|Setting[-_ ]up|Ubuntu[-_]HA|How[-_]to[-_]Install)", re.I), "setup"),

	# Migration / restoring / upgrade
	(re.compile(r"^(Migration|Migrating|Restoring|Updating|ERPNext[-_]Upgrade)", re.I), "migration"),

	# Testing
	(re.compile(r"^(Test[-_]|Standard[-_]Release[-_]Test|How[-_]to[-_]test|Troubleshooting)", re.I), "testing"),

	# Contribution / community process
	(re.compile(r"^(Contribution|Pull[-_]Request|How[-_]to[-_]contribute|How[-_]To[-_]Make[-_]Regional|Cascading|Issue[-_]Guidelines|Preparing[-_]a[-_]Contribution|Create[-_]User[-_]Stories)", re.I), "contribution"),

	# Releases / version notes
	(re.compile(r"^(Version[-_]|ERPNext[-_]Version|ERPNext[-_]Release[-_]Note|Supported[-_]Versions)", re.I), "releases"),

	# Modules / vertical features
	(re.compile(r"^(Manufacturing[-_]Module|Project[-_]Module|E[-_]Commerce|ERPNext[-_]for[-_])", re.I), "modules"),

	# Accounts / tax / bank (Expense-or-Difference dosyası tırnakla başlıyor — anchor yok)
	(re.compile(r"(Country[-_]wise[-_]Chart|Tax[-_]Withholding|Item[-_]Wise[-_]Tax|Bank[-_]Transaction|Expense[-_]or[-_]Difference)", re.I), "accounts"),

	# Stock / inventory
	(re.compile(r"^(Improve[-_]Precision[-_]of[-_]Stock|Stock[-_])", re.I), "stock"),

	# Community / hub / governance
	(re.compile(r"^(Community[-_]|Hub[-_]|Module[-_]Maintainers|Feature[-_]Suggestions|Future[-_]Development)", re.I), "community"),

	# Specifications / proposals / mockups
	(re.compile(r"^(\[Specifications\]|AgriNext[-_]Mockups|Agri[-_]+Farm|Agri[-_]Farm)|Feature[-_]Specification|Proposed[-_]Doc", re.I), "specs"),

	# Development / coding / tooling — nispeten geniş, en sona koyduk
	(re.compile(r"^(Coding|Code[-_]Security|Code[-_]Editing|Form[-_]Design|Model[-_]Design|Naming|Page[-_]format|ERPNext[-_]Performance|VSCode|Adding[-_]Custom|Designing[-_]Integrations|Integrating[-_]Emails|Guide[-_]to[-_]splitting|Export[-_]Custom)", re.I), "development"),
]

FRAPPE_RULES = [
	# Client-side scripting (parantezli isimler dahil)
	(re.compile(r"Client[-_]?[Ss]ide[-_]?[Ss]cripting|Client[-_]Side[-_]Scripting", re.I), "client-side-scripting"),

	# Migration / version / deprecations
	(re.compile(r"^(Migrating|Migration|Deprecations|query[-_]builder[-_]migration)", re.I), "migration"),

	# Setup / installation
	(re.compile(r"^(Installing|Setup[-_]|The[-_]Hitchhiker|Using[-_]Frappe[-_]with[-_]Amazon)", re.I), "installation"),

	# Testing
	(re.compile(r"^(Generating[-_]Test|Frappe[-_]Test[-_]Record|Writing[-_]an[-_]IntegrationTestCase)", re.I), "testing"),

	# Development / framework deep-dives / contribution review
	(re.compile(r"^(App[-_]Development|Developer[-_]Cheatsheet|Frappe[-_]Framework|Frappe[-_]Push|Tree[-_]view|Using[-_]Desk|Using[-_]the[-_]VSCode|Pull[-_]Request[-_]Review)", re.I), "development"),
]


def classify(filename: str, app: str) -> str | None:
	"""
	filename → folder name. None döner: dosya special (root'ta kal) veya skip-subdir.
	'misc' döner: hiçbir kural eşleşmedi.
	"""
	if filename in SPECIAL_FILES:
		return None
	rules = ERPNEXT_RULES if app == "erpnext" else FRAPPE_RULES
	for pattern, folder in rules:
		if pattern.search(filename):
			return folder
	return "misc"
