# Migration Guide: Query Builder Refactor

This guide outlines how to migrate your code to adapt to the recent Query Builder refactor in Frappe. The core change is that `frappe.get_list` and `frappe.get_all` now use the Pypika-based Query Builder internally. This enforces stricter parsing of fields and filters to prevent SQL injection and ensure consistency. We've tried to maintain backwards compatibility where possible to minimize the changes a developer would have to make.

## Biggest change: function usage

- You might have been using raw SQL strings for functions (e.g., `sum(field) as alias`). This is no longer supported.
- You need to use the new dict-based syntax for this.

### Old Code
```python
frappe.get_all(
    "Stock Ledger Entry",
    fields=["sum(actual_qty) as qty_after_transaction", "sum(stock_value_difference) as stock_value"],
    filters=filters
)
```

### New Code
```python
frappe.get_all(
    "Stock Ledger Entry",
    fields=[
        {"SUM": "actual_qty", "as": "qty_after_transaction"},
        {"SUM": "stock_value_difference", "as": "stock_value"},
    ],
    filters=filters
)
```

---

- Alternatively, you could also use the pypika functions directly. This might be required in some more complex scenarios.

### Old Code
```python
frappe.db.get_all(
			"GL Entry",
			filters={"account": self.debtors_usd, "is_cancelled": 0},
			fields=["sum(debit)-sum(credit) as balance"],
)
```

### New Code
```python
from frappe.query_builder import DocType, functions
gl = DocType("GL Entry")
acc_balance = frappe.db.get_all(
			"GL Entry",
			filters={"account": self.debtors_usd, "is_cancelled": 0},
			fields=[(functions.Sum(gl.debit) - functions.Sum(gl.credit)).as_("balance")],
)
```

---

- Depending on your usage, some functions like `IFNULL` may need a pypika `Field` as an argument.

### Old Code
```python
frappe.get_all(
		"Item",
		fields="name",
		filters={"name": ("in", list(items.keys())), "ifnull(is_stock_item, 0)": 0},
		as_list=1,
	)
```

### New Code
```python
non_stock_items = frappe.get_all(
		"Item",
		fields="name",
		filters=[
			["name", "in", list(items.keys())],
			[IfNull(Field("is_stock_item"), 0), "=", 0],
		],
		as_list=1,
	)
```

---

- Some complex `order_by` expressions may require direct use of query builder now.

### Old Code
```python
frappe.get_all(
    "Stock Ledger Entry",
    fields=["*"],
    filters=filters,
    order_by="timestamp(posting_date, posting_time), creation"
)
```

### New Code
```python
from frappe.query_builder.functions import Timestamp

sle = frappe.qb.DocType("Stock Ledger Entry")
query = (
    frappe.qb.from_(sle)
    .select("*")
    .where(sle.voucher_no == doc.name)
    # ... add other filters
    .orderby(Timestamp(sle.posting_date, sle.posting_time))
    .orderby(sle.creation)
    .run(as_dict=True)
)
```

---
## `distinct` fields

- Due to stricter checks, you can't do things like `distinct field_name` in your field list. You need to pass the `distinct` boolean parameter instead.

### Old Code
```python
frappe.get_all(
    "Serial No",
    fields=["distinct batch_no"],
    filters=filters
)
```

### New Code
```python
frappe.get_all(
    "Serial No",
    fields=["batch_no"],
    filters=filters,
    distinct=True
)
```

---

## Using Raw Values or Literals in Fields

For selecting literal values or constants in your fields, use Pypika's `ValueWrapper` to wrap raw values.

### Old Code
```python
fields=["'Leave Application' as doctype"]
```

### New Code
```python
from pypika.terms import ValueWrapper

fields=[ValueWrapper("Leave Application").as_("doctype")]
```

---

- Some syntax that might've worked in filters earlier would again require usage of query builder.

### Old Code
```python
 frappe.get_list("Loyalty Program", filters={
      "ifnull(to_date, '2500-01-01')": [">=", today()]
  })
```

### New Code
```python
  from frappe.query_builder import Field
  from frappe.query_builder.functions import IfNull

  frappe.get_list("Loyalty Program", filters=[
      [IfNull(Field("to_date"), "2500-01-01"), ">=", today()]
  ])
```

---

## JSON filters

Filters in Dashboard Charts, Number Cards, and other JSON configurations previously allowed a 5th element that was deprecated. This has been removed as the query builder now strictly validates filter formats.

### Old Code (JSON)
```json
{
  "filters_json": "[[\"Employee\",\"status\",\"=\",\"Active\",false]]"
}
```

### New Code (JSON)
```json
{
  "filters_json": "[[\"Employee\",\"status\",\"=\",\"Active\"]]"
}
```

The 5th element (typically `false`) had no effect and has been removed. Filters must now be either:
- 2 elements: `[field, value]` (implies `=` operator)
- 3 elements: `[field, operator, value]`
- 4 elements: `[doctype, field, operator, value]` (explicit doctype)

---

## Using IfNull in filters

When you need to check if a field is null or empty, use the `IfNull` function from `frappe.query_builder.functions`. The field name must be wrapped with `Field()` to properly reference the column.

### Old Code
```python
filters = [
    ['ifnull(`parent_task`, "")', "=", ""]
]
```

### New Code
```python
from frappe.query_builder import Field, functions

filters = [
    functions.IfNull(Field("parent_task"), "") == ""
]
```

**Note:** You can use either:
- Criterion format: `IfNull(Field("field"), "") == ""` (recommended for function-based filters)
- List format: `["field", "=", value]` (for simple field comparisons)

Both the 3-element `[field, operator, value]` and 4-element `[doctype, field, operator, value]` formats are valid. The 4-element format is more explicit and useful when dealing with complex queries involving multiple doctypes.

## `run` parameter

Previously, `run=0` or `run=False` would return a string query. Now, `run=False` returns a `QueryBuilder` object, which can be further manipulated or executed.
If you want the string query, you can do `query.get_sql()`.
