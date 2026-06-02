Guide for upgrading Tax Withholding from earlier versions to v16.<br>
https://github.com/frappe/erpnext/pull/51099

## What Changed in v16

The TDS/TCS system was refactored to use a new `Tax Withholding Entry` child table for detailed tracking.

### Old Structure

| DocType | TDS Data Location |
|---------|-------------------|
| Purchase Invoice | `taxes` table, `tax_withheld_vouchers`, `advance_tax` |
| Sales Invoice | `taxes` table |
| Payment Entry | `advance_taxes_and_charges` with `allocated_amount` |
| Journal Entry | `accounts` table with `is_tax_withholding_account` |

### New Structure

| DocType | TDS Data Location |
|---------|-------------------|
| All | `tax_withholding_entries` child table with detailed tracking |

---

When upgrading to v16, the system automatically:

### 1. Migrates Purchase Invoice TDS
- Entries from `taxes` table with TDS accounts
- Historical `tax_withheld_vouchers` entries
- `advance_tax` allocations from Payment Entries

### 2. Migrates Sales Invoice TCS
- Entries from `taxes` table with TCS accounts

### 3. Migrates Payment Entry TDS
- Advance tax entries (allocated and unallocated)
- Creates "Over Withheld" entries for unallocated advances
- Creates "Duplicate" entries for cross-document references

### 4. Migrates Journal Entry TDS
- Debit/Credit Note TDS entries

### 5. Copies Party Category to Items
- `tax_withholding_category` from invoice level copied to item rows
- Enables item-level TDS going forward

---

## Removed Features

| Feature | Status |
|---------|--------|
| Purchase Order TDS | Removed |
| Purchase Receipt TDS | Removed |
| Old `advance_tax` table | Replaced by `Tax Withholding Entry` |
| Old `tax_withheld_vouchers` table | Replaced by `Tax Withholding Entry` |

---

## New Features in v16

| Feature | Description |
|---------|-------------|
| **Tax Withholding Entry** | Unified child table for all document types |
| **Item-Level TDS** | Different categories per item in same invoice |
| **Tax Withholding Groups** | Different rates for Individuals vs Companies |
| **Improved LDC Handling** | Automatic split between LDC and normal rates |
| **Cross Fiscal Year** | Over Withheld entries carry forward |
| **Tax on Excess Amount** | Tax only on amount exceeding threshold |

---