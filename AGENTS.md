# AGENTS.md

ERPNext: open-source ERP built on the Frappe Framework. Python (server controllers, business logic) + JavaScript (Desk client, form scripts) + Frappe metadata (DocType JSON schemas).

> If a `CLAUDE.local.md` file exists alongside this file, read and respect it — it contains developer-specific overrides that supplement this shared guidance.

## Rules (Read First)

**CRITICAL (YOU MUST):**
- ERPNext is a Frappe app, not a standalone application. The `bench` CLI from `frappe-bench` is the only entry point — never invoke ERPNext code from this checkout directly.
- Run all `bench` commands from `~/frappe-bench`, NOT from this repo. Lint/format runs from this repo.
- Pre-commit blocks direct commits to `develop` (`no-commit-to-branch`). Branch off `develop`; PRs to upstream target `develop` unless fixing a release branch.
- `@frappe.whitelist()` API methods MUST have type annotations — `require_type_annotated_api_methods = True` is set in `hooks.py`. Missing annotations break the boot.
- Schema-breaking change → write a patch under `erpnext/patches/v<N>_<n>/` and register it in `erpnext/patches.txt`. Never assume a fresh DB.
- Don't add immutable-ledger doctypes (`GL Entry`, `Stock Ledger Entry`, `Payment Ledger Entry`, `Advance Payment Ledger Entry`, `Account Closing Balance`, `Payment Entry`) to auto-cancel cascades — register them in `auto_cancel_exempted_doctypes` in `hooks.py` and write reverse entries instead.
- Don't reintroduce `debit`/`credit` columns to `Payment Ledger Entry` — it uses `account_type` + signed `amount` + `against_voucher_no` by design (see `erpnext/accounts/README.md`).
- Match existing style. Many ruff rules are intentionally disabled in `pyproject.toml`; do not "fix" `F401`/`E501`/etc. project-wide.

## Common Commands

`bench` commands assume CWD `~/frappe-bench`. Lint/format runs from this repo.

| Task | Command |
|------|---------|
| Dev server (web/worker/redis/scheduler) | `bench start` |
| Build JS/CSS bundles | `bench build --app erpnext` |
| Run patches + reload doctypes | `bench --site <site> migrate` |
| Frappe Python shell | `bench --site <site> console` |
| Clear cache after server change | `bench --site <site> clear-cache` |
| Single test module | `bench --site test_site run-tests --module erpnext.controllers.tests.test_accounts_controller --lightmode` |
| Single test method | append `--test <ClassName.test_method>` to above |
| Whole-app sharded tests (CI shape) | `bench --site test_site run-parallel-tests --lightmode --app erpnext --total-builds 4 --build-number <1..4> --with-coverage` |
| Lint + format (run from this repo) | `pre-commit run --all-files` |
| Refresh docs tree | `docs/organize-docs.sh` (re-runs the wiki/HTML→md pipeline) |

Test sites need `allow_tests: true` in `site_config.json` (reference: `.github/helper/site_config_mariadb.json`). `--lightmode` skips heavy fixture setup; CI uses it.

### Repo metadata

- Python: `>=3.14` (`pyproject.toml`)
- Frappe dependency: `>=17.0.0-dev,<18.0.0` (`[tool.bench.frappe-dependencies]`)
- Develop version: `17.x.x-develop` (`hooks.py: develop_version`)
- Ruff: tab indent, double quotes, line length 110, target `py310`

### Pre-commit pipeline

ruff (lint + format + import sort), prettier (JS/Vue/SCSS), eslint, AST/JSON/YAML/merge-conflict checks, `no-commit-to-branch` for `develop`. Semgrep in CI: `frappe/semgrep-rules` + local `semgrep/test-correctness.yml`.

## Architecture

### Module layout

`erpnext/` is the app package. The 21 modules in `erpnext/modules.txt` follow the Frappe convention: `<module>/doctype/<doctype_snake>/` containing `<doctype>.py` (server controller), `.js` (form script), `.json` (schema), and `test_<doctype>.py`. Reports, dashboards, print formats live in sibling subdirectories of the module.

Highest-traffic modules: `accounts`, `stock`, `selling`, `buying`, `manufacturing`, `subcontracting`, `assets`, `crm`, `projects`. `regional/` and `edi/` hold country-specific behaviors.

### Controller inheritance backbone

`erpnext/controllers/` defines the base classes that almost every transaction DocType inherits from. Touch one and you affect dozens of doctypes — read carefully before changing.

| Controller | Role |
|-----------|------|
| `accounts_controller.AccountsController` | Base for anything that hits the GL (invoices, payments, journal entries) |
| `selling_controller.SellingController` | Sales-side logic on top of `AccountsController` |
| `buying_controller.BuyingController` | Purchase-side logic on top of `AccountsController` |
| `stock_controller.StockController` | Stock ledger writes; parent for delivery notes, stock entries |
| `subcontracting_controller.SubcontractingController` | Subcontract flows (plus `subcontracting_inward_controller`) |
| `taxes_and_totals.calculate_taxes_and_totals` | Tax engine used by all transaction docs |
| `status_updater.StatusUpdater` | Status / percent-billed / percent-delivered across linked docs |
| `sales_and_purchase_return.py` | Return-document creation |

Client-side counterparts live in `erpnext/public/js/controllers/` (`transaction.js`, `accounts.js`, `buying.js`, `stock_controller.js`, `taxes_and_totals.js`).

### `hooks.py` — the wiring file

`erpnext/hooks.py` declares everything Frappe's loader picks up: `doc_events`, `scheduler_events`, `regional_overrides` (per-country method swaps for France/UAE/Saudi/Italy), `website_route_rules`, `doctype_js`, `extend_doctype_class`, `boot_session`, `extend_bootinfo`, plus authoritative module-level lists (`accounting_dimension_doctypes`, `period_closing_doctypes`, `repost_allowed_doctypes`, `auto_cancel_exempted_doctypes`).

New cross-cutting behavior (scheduled job, validate hook, regional override) almost always means editing this file. When adding a new transaction doctype that participates in accounting dimensions, period closing, or bank reconciliation, add it to the relevant list.

### Patches and migrations

`erpnext/patches.txt` (split into `pre_model_sync` / `post_model_sync` sections) lists migration scripts under `erpnext/patches/v<N>_<n>/`. `bench migrate` runs them in order, once each. Patches must be idempotent over existing data.

### Payment Ledger model

`erpnext/accounts/README.md` documents an important deviation from classical double-entry: `Payment Ledger Entry` uses `account_type` + signed `amount` + `against_voucher_no` instead of `debit`/`credit` columns. Outstanding amounts are `SUM(amount) GROUP BY against_voucher_no`. Reconciliation logic depends on this.

### Frontend bundles

`erpnext/public/js/erpnext.bundle.js` is the entry. Bundles wired in `hooks.py` (`app_include_js`, `web_include_css`, `email_css`). Per-DocType form scripts live next to the DocType JSON; cross-doctype overrides for non-ERPNext doctypes (Address, Contact, Communication, Event, Newsletter) go through `hooks.py` `doctype_js`.

### Regional behavior

Country-specific code lives under `erpnext/regional/<country>/`. Dispatch happens via `regional_overrides` in `hooks.py`, consulted by Frappe's hook resolver based on the company's country. When fixing a country-specific bug, look there first — overrides may be replacing the generic method entirely.

## Key Files

| File | Role |
|------|------|
| `erpnext/hooks.py` | Frappe loader wiring (events, jobs, regional overrides, doctype lists) |
| `erpnext/modules.txt` | Authoritative list of 21 modules |
| `erpnext/patches.txt` | Migration runlist (pre/post model sync) |
| `erpnext/controllers/accounts_controller.py` | GL transaction base class |
| `erpnext/controllers/stock_controller.py` | Stock ledger base class |
| `erpnext/controllers/taxes_and_totals.py` | Tax engine |
| `erpnext/accounts/README.md` | Payment Ledger Entry model documentation |
| `erpnext/public/js/erpnext.bundle.js` | Frontend bundle entry |
| `pyproject.toml` | Ruff config + Python/Frappe version constraints |
| `.github/helper/site_config_mariadb.json` | Reference test site config |

## Design Patterns

| Pattern | Key Points |
|---------|------------|
| **Controller inheritance** | Transaction doctypes extend `AccountsController` / `SellingController` / `BuyingController` / `StockController`, not `frappe.model.document.Document` directly |
| **DocType layout** | One folder per doctype: `.py` (controller), `.js` (form script), `.json` (schema), `test_*.py` (tests) |
| **Cross-cutting wiring** | Goes through `hooks.py` (`doc_events`, `scheduler_events`, `regional_overrides`) — don't sprinkle imports across modules |
| **Schema changes** | Patch under `erpnext/patches/v<N>_<n>/`, registered in `patches.txt` (pre or post model sync) |
| **Immutable ledgers** | `GL Entry`, `Stock Ledger Entry`, `Payment Ledger Entry`, `Advance Payment Ledger Entry`, `Account Closing Balance` — never updated/deleted; write reversal entries instead |
| **Whitelist API** | `@frappe.whitelist()` requires type annotations (enforced by `require_type_annotated_api_methods`) |
| **Regional dispatch** | Generic method in core; country-specific override registered in `regional_overrides` of `hooks.py` |

## Anti-Patterns / Gotchas

- **Don't run from this checkout** — ERPNext is a Frappe app; everything goes through `bench` from `~/frappe-bench`.
- **Don't reintroduce `debit`/`credit` columns to Payment Ledger Entry** — see Architecture / Payment Ledger model.
- **Don't add immutable-ledger doctypes to auto-cancel cascades** — register in `auto_cancel_exempted_doctypes` in `hooks.py`.
- **Don't "fix" disabled ruff rules project-wide** — many are intentionally disabled in `pyproject.toml`. Match existing style.
- **CI shard non-determinism** — `--total-builds 4` shards tests across 4 containers; "passes locally, fails in CI" usually means cross-shard ordering. Use `run-individual-tests.yml` (manual dispatch) to isolate.
- **`--lightmode` is the CI default** — skips heavy fixture setup. If your test depends on full setup, mark it accordingly.
- **`bench migrate` runs patches once** — never assume a fresh DB; design patches to be idempotent over existing data.
- **Type annotations on whitelist methods are mandatory** — missing annotations break the boot.
- **Country-specific bugs may not be in core** — check `erpnext/regional/<country>/` first; the override may be replacing the generic method entirely.
- **Pre-commit hooks may modify files in-place** — if hooks fail, files are already changed. Re-stage and commit again; never `--amend` past a hook failure (the prior commit didn't happen, so amend would rewrite the wrong commit).

## Development Workflow

1. Branch off `develop` in this repo. Direct commits to `develop` are blocked by `no-commit-to-branch`.
2. Make changes; if schema changes, add a patch under `erpnext/patches/v<N>_<n>/` and register in `patches.txt`.
3. Run `pre-commit run --all-files` from this repo before pushing.
4. Run relevant tests via `bench --site test_site run-tests --module ... --lightmode` from `~/frappe-bench`.
5. Open PR — see Branching policy below.

## Branching policy and PRs

- Upstream (`upstream`): https://github.com/frappe/erpnext — target for upstream contributions.
- Fork (`origin`): https://github.com/faturamAI/faturam.ai — local default branch is `main`.
- Default upstream branch: `develop`. PRs to upstream target `develop` unless fixing a release branch.
- `.mergify.yml` and `.github/workflows/propogate-auto-merge.yml` automate release-branch backports.
- Use plain `git push` / `git fetch` / `git pull` — `gh` is configured as the credential helper, no extra setup needed.

## CI / Testing

| Layer | Workflow / Path | Notes |
|-------|-----------------|-------|
| Server tests (MariaDB) | `.github/workflows/server-tests-mariadb.yml` | 4-shard sharded, `--lightmode` |
| Server tests (Postgres) | `.github/workflows/server-tests-postgres.yml` | 4-shard sharded |
| Linters | `.github/workflows/linters.yml` | pre-commit + semgrep on every PR |
| Individual test runner | `.github/workflows/run-individual-tests.yml` | Manual dispatch — for isolating shard-order failures |
| Backports | `.mergify.yml`, `.github/workflows/propogate-auto-merge.yml` | Auto release-branch backports |
| Test site config | `.github/helper/site_config_mariadb.json` | `allow_tests: true` reference |

Tests share a site across cases — fixture state can leak. Use `frappe.db.rollback()` defensively, or `--lightmode` to skip heavy setup.

## Key Documentation

| Topic | Path |
|-------|------|
| Reorganized framework + user docs | `docs/frappe/`, `docs/erpnext/` |
| Doc reorganization pipeline | `docs/organize-docs.sh`, `docs/scripts/` |
| Payment Ledger model | `erpnext/accounts/README.md` |
| Module list | `erpnext/modules.txt` |
| Migration runlist | `erpnext/patches.txt` |
| Linter config | `pyproject.toml` (`tool.ruff`) |
| Code of conduct | `CODE_OF_CONDUCT.md` |
| Security policy | `SECURITY.md` |
| Trademark policy | `TRADEMARK_POLICY.md` |
