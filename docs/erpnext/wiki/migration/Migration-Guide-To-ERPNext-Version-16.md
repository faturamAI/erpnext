### Timesheet billing via API

If you create **Sales Invoices** via API, you sometimes want to fetch unbilled timesheets from the linked project. So far, this was the default behavior. Now you'll need to make an additional API call: `PUT /api/v2/document/Sales%20Invoice/SINV-0001/method/add_timesheet_data`

### New Party Bank Account via API

The whitelisted method `erpnext.accounts.doctype.bank_account.bank_account.make_bank_account` has been removed. It used to return a new **Bank Account** linked to a specific party. Instead, we use `frappe.new_doc` in the frontend directly. ([Removal PR](https://github.com/frappe/erpnext/pull/49001/files))

### New Pricing Rule via API

The whitelisted method `erpnext.accounts.doctype.pricing_rule.pricing_rule.make_pricing_rule` and the frontend util `erpnext.utils.make_pricing_rule` have been removed. They used to return a new **Pricing Rule** linked to a specific **Customer** or **Supplier**. Instead, we use `frappe.new_doc` in the frontend directly. ([Removal PR](https://github.com/frappe/erpnext/pull/49285))

### Germany: no Transaction Logs

Since v12, ERPNext used to store duplicates of submitted **Sales Invoices** and **Payment Entries** in a separate table, linked by a chained hash. This feature was originally designed for France but also enabled for Germany in an attempt to comply with some parts of KassenSichV. Because German POS compliance depends on a certified TSE, ERPNext cannot be compliant on its own, so the duplicate ledger provided no compliance benefit and has been removed. ([Removal PR](https://github.com/frappe/erpnext/pull/49383))


### Item Wise Tax Details: JSON → Child Table

[Detailed Migration Guide](https://github.com/frappe/erpnext/wiki/Item-Wise-Tax-Details:-JSON-%E2%86%92-Child-Table)<br>
ERPNext has migrated from a legacy JSON field (`item_wise_tax_detail`) to a fully relational child table (`Item Wise Tax Detail`) for tracking tax breakdowns at the item level.([PR Link](https://github.com/frappe/erpnext/pull/48692))


### Tax Withholding Entry

The Tax Withholding is refactored to use a new `Tax Withholding Entry` child table for detailed tracking.

[PR Link](https://github.com/frappe/erpnext/pull/51099)<br>
[Detailed Migration Guide](https://github.com/frappe/erpnext/wiki/Tax-Withholding-Entry)<br>



