## Item Wise Tax Details: JSON → Child Table

### Resources

| Type | Link |
|------|------|
| **PR** | [erpnext#48692](https://github.com/frappe/erpnext/pull/48692) |

### What Changed

ERPNext has migrated from a legacy JSON field (`item_wise_tax_detail`) to a fully relational child table (`Item Wise Tax Detail`) for tracking tax breakdowns at the item level.

### Impact

This affects:
- Custom tax calculation logic
- Reports that read tax breakdowns
- Integrations that manipulate tax data

---

### Old Structure (v15)

```python
# JSON field on each tax row
tax_row.item_wise_tax_detail = json.dumps({
    "ITEM-001": {
        "tax_rate": 10.0,
        "tax_amount": 100.0,
        "net_amount": 1000.0
    },
    "ITEM-002": {
        "tax_rate": 10.0,
        "tax_amount": 50.0,
        "net_amount": 500.0
    }
})
```

### New Structure (v16)

```python
# Child table: Item Wise Tax Detail
doc.item_wise_tax_details = [
    {
        "item_row": "abc123",         # Reference to item row name
        "tax_row": "def456",          # Reference to tax row name
        "rate": 10.0,
        "amount": 100.0,
        "taxable_amount": 1000.0
    },
    # ... more rows
]
```

---

### Internal Calculation Phase

During tax calculation (before save), the system uses a **temporary in-memory list** called `_item_wise_tax_details`:

```python
# Internal structure during calculation
doc._item_wise_tax_details = [
    frappe._dict(
        item=<Item Row Object>,       # Actual item row object
        tax=<Tax Row Object>,         # Actual tax row object
        rate=10.0,
        amount=100.0,
        taxable_amount=1000.0
    ),
    # ... more entries
]
```

> **Note:** The `on_update()` hook automatically converts this temporary list to child table records.

---

### Key Changes Required

#### 1. Remove JSON Field Manipulation

**Old (v15):**
```python
import json

tax_row["item_wise_tax_detail"] = json.dumps({
    "ITEM-001": {"tax_rate": 10, "tax_amount": 100, "net_amount": 1000}
})
```

**New (v16):**
```python
# Don't set item_wise_tax_detail on tax rows
# The system handles this automatically via _item_wise_tax_details
```

---

#### 2. Use Object References Instead of Item Codes

**Old (v15):**
```python
# Keyed by item_code string
item_wise_tax_detail[item_code] = [rate, amount]
```

**New (v16):**
```python
# Store actual item and tax row objects
doc._item_wise_tax_details.append(
    frappe._dict(
        item=item_row,         # Row object, not item_code string
        tax=tax_row,           # Row object, not tax name string
        rate=rate,
        amount=amount,
        taxable_amount=taxable_amount
    )
)
```

---

#### 3. Set `dont_recompute_tax` Flag

When manually setting taxes, prevent ERPNext from recalculating:

```python
tax_row = {
    "charge_type": "Actual",
    "account_head": account_head,
    "tax_amount": 100.0,
    "dont_recompute_tax": 1,  # Required to prevent recalculation
}
```

---

#### 4. Manually Creating Item Wise Tax Details

If you need to manually create item-wise tax breakdowns (e.g., for custom tax logic or integrations), you must:

1. **Populate the temporary `_item_wise_tax_details` list** with row objects
2. **Set `dont_recompute_tax = 1`** on tax rows to prevent ERPNext from overwriting your values

```python
# Step 1: Initialize the temporary list if not exists
if not hasattr(doc, "_item_wise_tax_details"):
    doc._item_wise_tax_details = []

# Step 2: Add your custom tax details
for item_row in doc.items:
    for tax_row in doc.taxes:
        # Set flag to prevent automatic recalculation
        tax_row.dont_recompute_tax = 1

        # Calculate your custom tax values
        taxable_amount = item_row.net_amount
        rate = 18.0  # Your custom rate
        amount = taxable_amount * rate / 100

        # Append to temporary list (uses row objects, not strings)
        doc._item_wise_tax_details.append(
            frappe._dict(
                item=item_row,           # Row object reference
                tax=tax_row,             # Row object reference
                rate=rate,
                amount=amount,
                taxable_amount=taxable_amount
            )
        )

# Step 3: The system will automatically convert _item_wise_tax_details
# to the child table on save via on_update() hook
doc.save()
```

> **Important:** Always set `dont_recompute_tax = 1` on each tax row when manually populating tax details, otherwise ERPNext will recalculate and overwrite your values during `calculate_taxes_and_totals()`.

---

#### 5. Update Reports

Reports that previously parsed the JSON field must now query the child table:

**Old (v15):**
```python
import json

tax_detail = json.loads(tax_row.item_wise_tax_detail or "{}")
for item_code, values in tax_detail.items():
    rate = values.get("tax_rate")
```

**New (v16):**
```python
tax_details = frappe.get_all(
    "Item Wise Tax Detail",
    filters={"parent": doc.name},
    fields=["item_row", "tax_row", "rate", "amount", "taxable_amount"]
)

for detail in tax_details:
    rate = detail.rate
```

---



### Example PRs

- [india-compliance#3807](https://github.com/resilient-tech/india-compliance/pull/3807)

---

### Example: Shopify Integration

This example demonstrates migrating a Shopify order sync that creates Sales Invoices with tax data.

#### Old Implementation (v15)

```python
def get_order_taxes(shopify_order, setting, items, doc=None):
    tax_account_wise_data = {}

    for line_item in shopify_order.get("line_items"):
        item_code = get_item_code(line_item)

        for tax in line_item.get("tax_lines"):
            account_head = get_tax_account_head(tax)

            # Old: Initialize JSON structure
            tax_account_wise_data.setdefault(
                account_head,
                {
                    "charge_type": "Actual",
                    "description": tax.get("title"),
                    "cost_center": setting.cost_center,
                    "tax_amount": 0,
                    "item_wise_tax_detail": {},  # JSON field (deprecated)
                },
            )

            # Old: Update JSON field with item_code as key
            tax_account_wise_data[account_head]["tax_amount"] += flt(tax.get("price"))
            tax_account_wise_data[account_head]["item_wise_tax_detail"].setdefault(
                item_code, [flt(tax.get("rate"), 4) * 100, 0]
            )
            tax_account_wise_data[account_head]["item_wise_tax_detail"][item_code][1] += flt(
                tax.get("price")
            )

    # Old: Convert to JSON string
    taxes = []
    for account, tax_row in tax_account_wise_data.items():
        row = {"account_head": account, **tax_row}
        row["item_wise_tax_detail"] = json.dumps(row.get("item_wise_tax_detail", {}))
        taxes.append(row)

    doc.update({"items": items, "taxes": taxes})
```

#### New Implementation (v16)

```python
def get_order_taxes(shopify_order, setting, items, doc=None):
    tax_account_wise_data = {}
    item_code_to_row_map = {}  # Map item_code to item row objects

    # Build mapping from item_code to item row object
    for item_row in items:
        item_code = item_row.get("item_code")
        item_code_to_row_map[item_code] = item_row

    for line_item in shopify_order.get("line_items"):
        item_code = get_item_code(line_item)
        item_row = item_code_to_row_map.get(item_code)  # Get item row object

        if not item_row:
            continue

        for tax in line_item.get("tax_lines"):
            account_head = get_tax_account_head(tax)

            # New: Initialize without item_wise_tax_detail JSON
            tax_account_wise_data.setdefault(
                account_head,
                {
                    "charge_type": "Actual",
                    "description": tax.get("title"),
                    "cost_center": setting.cost_center,
                    "dont_recompute_tax": 1,  # Important: prevents recalculation
                    "tax_amount": 0,
                },
            )

            tax_account_wise_data[account_head]["tax_amount"] += flt(tax.get("price"))

    # New: Create tax rows first
    taxes = []
    for account, tax_data in tax_account_wise_data.items():
        tax_row = {"account_head": account, **tax_data}
        taxes.append(tax_row)

    doc.update({"items": items, "taxes": taxes})

    # New: Populate _item_wise_tax_details after items and taxes are set
    doc._item_wise_tax_details = []

    # Build tax row mapping
    tax_row_map = {}
    for tax_row in doc.get("taxes"):
        tax_row_map[tax_row.account_head] = tax_row

    # Populate item wise tax details
    for line_item in shopify_order.get("line_items"):
        item_code = get_item_code(line_item)
        item_row = item_code_to_row_map.get(item_code)

        if not item_row:
            continue

        for tax in line_item.get("tax_lines"):
            account_head = get_tax_account_head(tax)
            tax_row = tax_row_map.get(account_head)

            if not tax_row:
                continue

            # Append to temporary list with row objects
            doc._item_wise_tax_details.append(
                frappe._dict(
                    item=item_row,           # Item row object
                    tax=tax_row,             # Tax row object
                    rate=flt(tax.get("rate"), 4) * 100,
                    amount=flt(tax.get("price")),
                    taxable_amount=_get_item_price(line_item, shopify_order.get("taxes_included"))
                )
            )
```


