```
Fixed BOM value not updating on changing item (#9350)
M	erpnext/manufacturing/doctype/bom/bom.js

[minor] set_posting_time=1 only when imported data contains posting date. (#9349)
M	erpnext/utilities/transaction_base.py

[fixes] fix message and type conversion;
M	erpnext/hr/doctype/expense_claim_type/expense_claim_type.py
M	erpnext/stock/doctype/stock_entry/stock_entry.py
M	erpnext/utilities/transaction_base.py

Addition of new fields for POS Profile in Sales Invoice and POS Profile User link modification (#9339)
M	erpnext/accounts/doctype/pos_profile/pos_profile.json
M	erpnext/accounts/doctype/sales_invoice/sales_invoice.json
M	erpnext/accounts/page/pos/pos.js

replaced some old images with new, #9262 (#9335)
A	erpnext/docs/assets/img/accounts/bank-reconciliation-2.png
D	erpnext/docs/assets/img/accounts/company_default_inventory_account.png
D	erpnext/docs/assets/img/accounts/inventory_account.png
D	erpnext/docs/assets/img/accounts/perpetual-2.png
D	erpnext/docs/assets/img/accounts/perpetual-3.png
A	erpnext/docs/assets/img/accounts/perpetual-dn-gl-5.png
A	erpnext/docs/assets/img/accounts/perpetual-dn-sl-4.png
A	erpnext/docs/assets/img/accounts/perpetual-inv-gl-7.png
A	erpnext/docs/assets/img/accounts/perpetual-inv-sl-6.png
A	erpnext/docs/assets/img/accounts/perpetual-pinv-gl-3.png
A	erpnext/docs/assets/img/accounts/perpetual-receipt-gl-2.png
A	erpnext/docs/assets/img/accounts/perpetual-receipt-sl-1.png
A	erpnext/docs/assets/img/accounts/perpetual-st-issue-gl.png
A	erpnext/docs/assets/img/accounts/perpetual-st-issue-sl.png
A	erpnext/docs/assets/img/accounts/perpetual-st-receipt-gl.png
A	erpnext/docs/assets/img/accounts/perpetual-st-receipt-sl.png
A	erpnext/docs/assets/img/accounts/perpetual-st-transfer-gl.png
A	erpnext/docs/assets/img/accounts/perpetual-st-transfer-sl.png
D	erpnext/docs/assets/img/collaboration-tools/calendar-7.png
R076	erpnext/docs/assets/old_images/erpnext/calender-email-digest.png	erpnext/docs/assets/img/collaboration-tools/calender-email-digest.png
D	erpnext/docs/assets/old_images/erpnext/accounting-for-stock-10.png
D	erpnext/docs/assets/old_images/erpnext/accounting-for-stock-11.png
D	erpnext/docs/assets/old_images/erpnext/accounting-for-stock-12.png
D	erpnext/docs/assets/old_images/erpnext/accounting-for-stock-13.png
D	erpnext/docs/assets/old_images/erpnext/accounting-for-stock-14.png
D	erpnext/docs/assets/old_images/erpnext/accounting-for-stock-4.png
D	erpnext/docs/assets/old_images/erpnext/accounting-for-stock-5.png
D	erpnext/docs/assets/old_images/erpnext/accounting-for-stock-6.png
D	erpnext/docs/assets/old_images/erpnext/accounting-for-stock-7.png
D	erpnext/docs/assets/old_images/erpnext/accounting-for-stock-8.png
D	erpnext/docs/assets/old_images/erpnext/accounting-for-stock-9.png
D	erpnext/docs/assets/old_images/erpnext/auto-notification.png
D	erpnext/docs/assets/old_images/erpnext/backup-manager.png
D	erpnext/docs/assets/old_images/erpnext/bank-reconciliation-2.png
D	erpnext/docs/assets/old_images/erpnext/budgeting-4.png
D	erpnext/docs/assets/old_images/erpnext/budgeting.png
D	erpnext/docs/assets/old_images/erpnext/calender-event-lead.png
D	erpnext/docs/assets/old_images/erpnext/calender-event-manually.png
D	erpnext/docs/assets/old_images/erpnext/calender-event-notification.png
D	erpnext/docs/assets/old_images/erpnext/calender-event-permission.png
D	erpnext/docs/assets/old_images/erpnext/calender-event-recurring.png
D	erpnext/docs/assets/old_images/erpnext/dropbox-access.png
M	erpnext/docs/user/manual/de/accounts/budgeting.md
M	erpnext/docs/user/manual/de/accounts/setup/cost-center.md
D	erpnext/docs/user/manual/de/setting-up/third-party-backups.md
M	erpnext/docs/user/manual/de/stock/accounting-of-inventory-stock/perpetual-inventory.md
M	erpnext/docs/user/manual/en/accounts/tools/bank-reconciliation.md
M	erpnext/docs/user/manual/en/setting-up/email/email-account.md
D	erpnext/docs/user/manual/en/setting-up/third-party-backups.md
M	erpnext/docs/user/manual/en/stock/accounting-of-inventory-stock/perpetual-inventory.md
M	erpnext/docs/user/manual/en/using-erpnext/calendar.md

[minor] use reload_doc instead of reload_doctype
M	erpnext/patches/v8_0/create_domain_docs.py

[demo] make it faster, do not send user email
M	erpnext/commands/__init__.py
M	erpnext/demo/setup/setup_data.py

[UX] Error in purchase transaction - Ignore instead of Prompt #7766 (#9329)
M	erpnext/controllers/buying_controller.py

Create a project from a Sales Order (#9111)
M	erpnext/projects/doctype/project/project.py
M	erpnext/selling/doctype/sales_order/sales_order.js
M	erpnext/selling/doctype/sales_order/sales_order.py

[minor] reload Domain doctype before executing patch
M	erpnext/patches/v8_0/create_domain_docs.py

[minor] fixed the child table field name (#9328)
M	erpnext/patches.txt
M	erpnext/patches/v8_0/create_domain_docs.py
M	erpnext/setup/setup_wizard/setup_wizard.py

[hot] fix global name args is not defined (#9326)
M	erpnext/patches/v8_0/create_domain_docs.py

Add .eslintrc for codacy (#9321)
A	.eslintrc

[fix] Patch for move account head from account to warehouse (#9325)
M	erpnext/patches/v8_0/move_account_head_from_account_to_warehouse_for_inventory.py

Merge branch 'pratu16x7-domainify' into domainify (#9324)
M	erpnext/patches.txt
A	erpnext/patches/v8_0/create_domain_docs.py
M	erpnext/setup/setup_wizard/domainify.py
M	erpnext/setup/setup_wizard/install_fixtures.py
M	erpnext/setup/setup_wizard/setup_wizard.py

Training Events/Results link added to Employee (#9313)
M	erpnext/hr/doctype/employee/employee_dashboard.py

created help page for email inbox, fixes #9262 (#9315)
A	erpnext/docs/assets/img/setup/email/email-actions.png
A	erpnext/docs/assets/img/setup/email/email-domain.png
A	erpnext/docs/assets/img/setup/email/email-folders.png
A	erpnext/docs/assets/img/setup/email/email-inbox.png
A	erpnext/docs/assets/img/setup/email/email-password.png
A	erpnext/docs/assets/img/setup/email/email-service.png
A	erpnext/docs/assets/img/setup/email/email-user-link.png
A	erpnext/docs/assets/img/setup/email/email-user.png
A	erpnext/docs/assets/img/setup/email/make-from-email.png
A	erpnext/docs/user/manual/en/setting-up/email/email-inbox.md
M	erpnext/docs/user/manual/en/setting-up/email/index.txt

Fix get_parents context (#9296)
M	erpnext/stock/doctype/item/item.py

fix logic of quantity validation (#9311)
M	erpnext/accounts/doctype/purchase_invoice/purchase_invoice.py
M	erpnext/accounts/doctype/sales_invoice/sales_invoice.py
M	erpnext/buying/doctype/purchase_order/purchase_order.py
M	erpnext/selling/doctype/sales_order/sales_order.py
M	erpnext/stock/doctype/delivery_note/delivery_note.py

bug in training result module (#9314)
M	erpnext/hr/doctype/training_result/training_result.js
M	erpnext/hr/doctype/training_result/training_result.json

Revert "sets tax category to "Total" if all items are non-stock items (#9295)" (#9320)
M	erpnext/controllers/buying_controller.py

sets tax category to "Total" if all items are non-stock items (#9295)
M	erpnext/controllers/buying_controller.py

Create journal_entry.py
M	erpnext/accounts/doctype/journal_entry/journal_entry.py

Warehouse Account Linking (#9292)
M	erpnext/accounts/doctype/account/account.json
M	erpnext/accounts/doctype/account/account.py
M	erpnext/accounts/doctype/account/account_tree.js
M	erpnext/accounts/doctype/account/chart_of_accounts/chart_of_accounts.py
M	erpnext/accounts/doctype/account/chart_of_accounts/verified/ae_uae_chart_template_standard.json
M	erpnext/accounts/doctype/account/chart_of_accounts/verified/fr_chart_of_accounts.json
M	erpnext/accounts/doctype/account/chart_of_accounts/verified/in_standard_chart_of_accounts.json
M	erpnext/accounts/doctype/account/chart_of_accounts/verified/sg_default_coa.json
M	erpnext/accounts/doctype/account/chart_of_accounts/verified/sg_fnb_coa.json
M	erpnext/accounts/doctype/account/chart_of_accounts/verified/standard_chart_of_accounts.py
M	erpnext/accounts/doctype/account/test_account.py
M	erpnext/accounts/doctype/accounts_settings/accounts_settings.py
M	erpnext/accounts/doctype/journal_entry/test_journal_entry.py
M	erpnext/accounts/doctype/mode_of_payment/mode_of_payment.py
M	erpnext/accounts/doctype/purchase_invoice/purchase_invoice.py
M	erpnext/accounts/doctype/purchase_invoice/test_purchase_invoice.py
M	erpnext/accounts/doctype/sales_invoice/test_sales_invoice.py
M	erpnext/accounts/general_ledger.py
M	erpnext/accounts/utils.py
M	erpnext/controllers/accounts_controller.py
M	erpnext/controllers/stock_controller.py
A	erpnext/docs/assets/img/accounts/company_default_inventory_account.png
A	erpnext/docs/assets/img/accounts/inventory_account.png
M	erpnext/docs/license.html
M	erpnext/docs/user/manual/en/stock/accounting-of-inventory-stock/perpetual-inventory.md
M	erpnext/patches.txt
M	erpnext/patches/v7_0/create_warehouse_nestedset.py
M	erpnext/patches/v7_0/repost_future_gle_for_purchase_invoice.py
A	erpnext/patches/v8_0/move_account_head_from_account_to_warehouse_for_inventory.py
M	erpnext/setup/doctype/company/company.js
M	erpnext/setup/doctype/company/company.json
M	erpnext/setup/doctype/company/company.py
M	erpnext/setup/doctype/company/test_company.py
M	erpnext/stock/__init__.py
M	erpnext/stock/doctype/delivery_note/test_delivery_note.py
M	erpnext/stock/doctype/landed_cost_voucher/test_landed_cost_voucher.py
M	erpnext/stock/doctype/purchase_receipt/purchase_receipt.py
M	erpnext/stock/doctype/purchase_receipt/test_purchase_receipt.py
M	erpnext/stock/doctype/stock_entry/test_stock_entry.py
M	erpnext/stock/doctype/warehouse/test_warehouse.py
M	erpnext/stock/doctype/warehouse/warehouse.js
M	erpnext/stock/doctype/warehouse/warehouse.json
M	erpnext/stock/doctype/warehouse/warehouse.py

Added new help pages as per OKR - DO NOT MERGE (#9291)
A	erpnext/docs/assets/img/collaboration-tools/delete-a-doc.png
A	erpnext/docs/assets/img/collaboration-tools/deleted-docs-list.gif
A	erpnext/docs/assets/img/collaboration-tools/enable-versioning.png
A	erpnext/docs/assets/img/collaboration-tools/restore-a-doc.png
A	erpnext/docs/assets/img/collaboration-tools/restored-doc.png
A	erpnext/docs/assets/img/collaboration-tools/version-details.png
A	erpnext/docs/assets/img/collaboration-tools/version-links.png
A	erpnext/docs/assets/img/schools/assessment/__init__.py
A	erpnext/docs/assets/img/schools/assessment/assessment-criteria.png
A	erpnext/docs/assets/img/schools/assessment/assessment-group-details.png
A	erpnext/docs/assets/img/schools/assessment/assessment-group-term.png
A	erpnext/docs/assets/img/schools/assessment/assessment-plan-criteria.png
A	erpnext/docs/assets/img/schools/assessment/assessment-plan-details.png
A	erpnext/docs/assets/img/schools/assessment/assessment-result-tool.png
A	erpnext/docs/assets/img/schools/assessment/assessment-result.png
A	erpnext/docs/assets/img/schools/assessment/grading-scale.png
A	erpnext/docs/user/manual/en/schools/Assessment/__init__.py
A	erpnext/docs/user/manual/en/schools/Assessment/assessment_criteria.md
A	erpnext/docs/user/manual/en/schools/Assessment/assessment_group.md
A	erpnext/docs/user/manual/en/schools/Assessment/assessment_plan.md
A	erpnext/docs/user/manual/en/schools/Assessment/assessment_result.md
A	erpnext/docs/user/manual/en/schools/Assessment/assessment_result_tool.md
A	erpnext/docs/user/manual/en/schools/Assessment/grading_scale.md
A	erpnext/docs/user/manual/en/schools/Assessment/index.md
A	erpnext/docs/user/manual/en/schools/Assessment/index.txt
M	erpnext/docs/user/manual/en/schools/index.txt
M	erpnext/docs/user/manual/en/stock/stock-entry.md
A	erpnext/docs/user/manual/en/using-erpnext/document-versioning.md
M	erpnext/docs/user/manual/en/using-erpnext/index.txt
A	erpnext/docs/user/manual/en/using-erpnext/restore-deleted-docs.md

changes `journal_entry.get_exchange_rate` to return exchange rate at date not average exchange rate
M	erpnext/accounts/doctype/journal_entry/journal_entry.py

Minor changes in the UX and courses automatically fetched upon saving (#9264)
M	erpnext/schools/doctype/program_course/program_course.json
M	erpnext/schools/doctype/program_enrollment/program_enrollment.js
M	erpnext/schools/doctype/program_enrollment/program_enrollment.json

make quotation against lead company name (#9188)
M	erpnext/crm/doctype/lead/lead.py

remove bracket (#9284)
M	erpnext/controllers/sales_and_purchase_return.py

[minor] Check if item is stock item before validating Warehouse while Purchase Return (#9282)
M	erpnext/controllers/sales_and_purchase_return.py

Show Stock Level only if any value(actual, reserved, reserved for production or projected) exists (#9168)
M	erpnext/stock/dashboard/item_dashboard.py

fix in the item for the function make_variant_item_code (#9280)
M	erpnext/stock/doctype/item/item.py

change in the absent student report (#9185)
M	erpnext/schools/report/absent_student_report/absent_student_report.py

[minor] fixed Cannot read property 'default_letter_head' of undefined (#9268)
M	erpnext/accounts/report/accounts_receivable/accounts_receivable.html
M	erpnext/accounts/report/financial_statements.html
M	erpnext/accounts/report/general_ledger/general_ledger.html

move bom based rate calculation to end (#9271)
M	erpnext/manufacturing/doctype/bom/bom.py

[minor] remove hardcoded flt precision and use system default (#9250)
M	erpnext/stock/report/stock_balance/stock_balance.py

fixes #8941: Better error message for duplicate items (#8968)
M	erpnext/manufacturing/doctype/bom/bom.py

Solve issue for while changing status of sales order page not reloading (#9204)
M	erpnext/selling/doctype/sales_order/sales_order.js

[hot] fixed ImportError: Module import failed for Company (erpnext.setup.doctype.company.company)
M	erpnext/setup/doctype/company/company.py

Salutation and Gender in Lead and Customer (#9199)
M	erpnext/accounts/doctype/tax_rule/tax_rule.py
M	erpnext/accounts/party.py
M	erpnext/buying/doctype/supplier/supplier.js
M	erpnext/buying/doctype/supplier/supplier.py
M	erpnext/crm/doctype/lead/lead.js
M	erpnext/crm/doctype/lead/lead.json
M	erpnext/crm/doctype/lead/lead.py
M	erpnext/hooks.py
M	erpnext/hr/doctype/employee/employee.json
M	erpnext/public/js/controllers/buying.js
M	erpnext/public/js/queries.js
M	erpnext/public/js/utils/party.js
M	erpnext/selling/doctype/customer/customer.js
M	erpnext/selling/doctype/customer/customer.json
M	erpnext/selling/doctype/customer/customer.py
M	erpnext/setup/doctype/sales_partner/sales_partner.js
M	erpnext/setup/doctype/sales_partner/sales_partner.py
M	erpnext/shopping_cart/cart.py

[translation] translation updates
M	erpnext/translations/ar.csv
M	erpnext/translations/da.csv
M	erpnext/translations/de.csv
M	erpnext/translations/es.csv
M	erpnext/translations/fr.csv
M	erpnext/translations/it.csv
M	erpnext/translations/nl.csv
M	erpnext/translations/uk.csv
M	erpnext/translations/vi.csv

Update purchase_order_dashboard.py (#9149)
M	erpnext/buying/doctype/purchase_order/purchase_order_dashboard.py

[enhance] create demo with function bench --site sitename make-demo` (#9212)
A	erpnext/commands/__init__.py
M	erpnext/demo/demo.py

changes expected payment_account in test case according to the fact that exchange rate should return latest saved rate
M	erpnext/accounts/doctype/payment_request/test_payment_request.py

fix for student monthly attendance report
M	erpnext/schools/report/student_monthly_attendance_sheet/student_monthly_attendance_sheet.py

[minor] removed the {next} from the last articles
M	erpnext/docs/user/manual/de/buying/setup/supplier-type.md
M	erpnext/docs/user/manual/de/setting-up/data/bulk-rename.md
M	erpnext/docs/user/manual/en/buying/setup/supplier-type.md
M	erpnext/docs/user/manual/en/setting-up/data/bulk-rename.md
M	erpnext/docs/user/manual/en/using-erpnext/articles/bulk-rename.md

[docs] removed the globals from documentation
M	erpnext/docs/user/manual/de/customize-erpnext/custom-scripts/custom-script-examples/date-validation.md
M	erpnext/docs/user/manual/de/customize-erpnext/custom-scripts/custom-script-examples/restrict-cancel-rights.md
M	erpnext/docs/user/manual/de/customize-erpnext/custom-scripts/custom-script-examples/restrict-purpose-of-stock-entry.md
M	erpnext/docs/user/manual/de/customize-erpnext/custom-scripts/custom-script-examples/restrict-user-based-on-child-record.md
M	erpnext/docs/user/manual/en/customize-erpnext/custom-scripts/custom-script-examples/date-validation.md
M	erpnext/docs/user/manual/en/customize-erpnext/custom-scripts/custom-script-examples/restrict-cancel-rights.md
M	erpnext/docs/user/manual/en/customize-erpnext/custom-scripts/custom-script-examples/restrict-purpose-of-stock-entry.md
M	erpnext/docs/user/manual/en/customize-erpnext/custom-scripts/custom-script-examples/restrict-user-based-on-child-record.md

makes sure latest test fixtures for currency exchange is retrieved before running test
M	erpnext/accounts/doctype/payment_entry/test_payment_entry.py

Fix incorrect YouTube link on Video Tutorials
M	erpnext/docs/user/videos/learn/report-builder.md

Fixing youtube link
M	erpnext/docs/user/videos/learn/bulk-update.md

Fixed wrong YouTube video link
M	erpnext/docs/user/videos/learn/budgeting.md

makes `set_exchange_rate` retrieve the latest exchange rate not average for "pay" and "internal transfer" payment entries
M	erpnext/accounts/doctype/payment_entry/payment_entry.py

adds test case to confirm that latest exchange rate is automatically selected
M	erpnext/accounts/doctype/payment_entry/test_payment_entry.py

adds new tests that verify that `get_exchange_rate` returns the latest exchange rate
M	erpnext/setup/doctype/currency_exchange/test_currency_exchange.py
M	erpnext/setup/doctype/currency_exchange/test_records.json

calls erpnext.setup.utils.get_exchange_rate instead of get_average_exchange_rate
M	erpnext/accounts/doctype/payment_entry/payment_entry.js

[fix] sys_defaults global in stock entry detail
M	erpnext/stock/doctype/stock_entry_detail/stock_entry_detail.json

[enhancement] Allow on Submit for Sales Order Customer PO and Customer PO Date (#9137)
M	erpnext/selling/doctype/sales_order/sales_order.json
M	erpnext/selling/doctype/sales_order/sales_order.py

Fix labels to accept translation in selling doctype (#9135)
M	erpnext/config/selling.py

Fix type (entrys) (#9131)
M	erpnext/docs/user/manual/en/accounts/index.md
M	erpnext/docs/user/manual/en/accounts/tools/bank-reconciliation.md
M	erpnext/docs/user/manual/en/accounts/tools/payment-tool.md
M	erpnext/docs/user/manual/en/introduction/concepts-and-terms.md

Help links added help_links.js (#9170)
M	erpnext/public/js/help_links.js

[minor] removed the deprecated inList method from eval (#9177)
M	erpnext/accounts/doctype/journal_entry/journal_entry.json

Fix typo (#9133)
M	erpnext/docs/user/manual/en/stock/delivery-note.md

[translation] translation updates (#9156)
M	erpnext/translations/am.csv
M	erpnext/translations/ar.csv
M	erpnext/translations/bg.csv
M	erpnext/translations/bn.csv
M	erpnext/translations/bs.csv
M	erpnext/translations/ca.csv
M	erpnext/translations/cs.csv
M	erpnext/translations/da-DK.csv
M	erpnext/translations/da.csv
M	erpnext/translations/de.csv
M	erpnext/translations/el.csv
M	erpnext/translations/es-CL.csv
M	erpnext/translations/es-GT.csv
M	erpnext/translations/es-MX.csv
M	erpnext/translations/es-PE.csv
M	erpnext/translations/es.csv
M	erpnext/translations/et.csv
M	erpnext/translations/fa.csv
M	erpnext/translations/fi.csv
M	erpnext/translations/fr-CA.csv
M	erpnext/translations/fr.csv
M	erpnext/translations/gu.csv
M	erpnext/translations/he.csv
M	erpnext/translations/hi.csv
M	erpnext/translations/hr.csv
M	erpnext/translations/hu.csv
M	erpnext/translations/id.csv
M	erpnext/translations/is.csv
M	erpnext/translations/it.csv
M	erpnext/translations/ja.csv
M	erpnext/translations/km.csv
M	erpnext/translations/kn.csv
M	erpnext/translations/ko.csv
M	erpnext/translations/ku.csv
M	erpnext/translations/lo.csv
M	erpnext/translations/lt.csv
M	erpnext/translations/lv.csv
M	erpnext/translations/mk.csv
M	erpnext/translations/ml.csv
M	erpnext/translations/mr.csv
M	erpnext/translations/ms.csv
M	erpnext/translations/my.csv
M	erpnext/translations/nl.csv
M	erpnext/translations/no.csv
M	erpnext/translations/pl.csv
M	erpnext/translations/ps.csv
M	erpnext/translations/pt-BR.csv
M	erpnext/translations/pt.csv
M	erpnext/translations/ro.csv
M	erpnext/translations/ru.csv
M	erpnext/translations/si.csv
M	erpnext/translations/sk.csv
M	erpnext/translations/sl.csv
M	erpnext/translations/sq.csv
M	erpnext/translations/sr.csv
M	erpnext/translations/sv.csv
M	erpnext/translations/ta.csv
M	erpnext/translations/te.csv
M	erpnext/translations/th.csv
M	erpnext/translations/tr.csv
M	erpnext/translations/uk.csv
M	erpnext/translations/ur.csv
M	erpnext/translations/vi.csv
M	erpnext/translations/zh-TW.csv
M	erpnext/translations/zh.csv

Fix contact form if email is both customer and lead (#9075)
M	erpnext/templates/utils.py

Weekly digest subject translation (#9003)
M	erpnext/setup/doctype/email_digest/email_digest.py

Arabic language shows Errors onSubmit  in maintenance_schedule (#9082)
M	erpnext/maintenance/doctype/maintenance_schedule/maintenance_schedule.py

[translation] translation updates (#9081)
M	erpnext/translations/am.csv
M	erpnext/translations/ar.csv
M	erpnext/translations/bg.csv
M	erpnext/translations/bn.csv
M	erpnext/translations/bs.csv
M	erpnext/translations/ca.csv
M	erpnext/translations/cs.csv
A	erpnext/translations/da-DK.csv
M	erpnext/translations/da.csv
M	erpnext/translations/de.csv
M	erpnext/translations/el.csv
M	erpnext/translations/es-AR.csv
M	erpnext/translations/es-CL.csv
M	erpnext/translations/es-GT.csv
M	erpnext/translations/es-NI.csv
M	erpnext/translations/es-PE.csv
M	erpnext/translations/es.csv
M	erpnext/translations/et.csv
M	erpnext/translations/fa.csv
M	erpnext/translations/fi.csv
M	erpnext/translations/fr.csv
M	erpnext/translations/gu.csv
M	erpnext/translations/he.csv
M	erpnext/translations/hi.csv
M	erpnext/translations/hr.csv
M	erpnext/translations/hu.csv
M	erpnext/translations/id.csv
M	erpnext/translations/is.csv
M	erpnext/translations/it.csv
M	erpnext/translations/ja.csv
M	erpnext/translations/km.csv
M	erpnext/translations/kn.csv
M	erpnext/translations/ko.csv
M	erpnext/translations/ku.csv
M	erpnext/translations/lo.csv
M	erpnext/translations/lt.csv
M	erpnext/translations/lv.csv
M	erpnext/translations/mk.csv
M	erpnext/translations/ml.csv
M	erpnext/translations/mr.csv
M	erpnext/translations/ms.csv
M	erpnext/translations/my.csv
M	erpnext/translations/nl.csv
M	erpnext/translations/no.csv
M	erpnext/translations/pl.csv
M	erpnext/translations/ps.csv
M	erpnext/translations/pt-BR.csv
M	erpnext/translations/pt.csv
M	erpnext/translations/ro.csv
M	erpnext/translations/ru.csv
M	erpnext/translations/si.csv
M	erpnext/translations/sk.csv
M	erpnext/translations/sl.csv
M	erpnext/translations/sq.csv
M	erpnext/translations/sr.csv
M	erpnext/translations/sv.csv
M	erpnext/translations/ta.csv
M	erpnext/translations/te.csv
M	erpnext/translations/th.csv
M	erpnext/translations/tr.csv
M	erpnext/translations/uk.csv
M	erpnext/translations/ur.csv
M	erpnext/translations/vi.csv
M	erpnext/translations/zh-TW.csv
M	erpnext/translations/zh.csv

Fixed issue : Payment Entry allocating amount more than invoice amount. (#9084)
M	erpnext/accounts/doctype/payment_entry/payment_entry.py

Set website route field as No Copy field (#9106)
M	erpnext/stock/doctype/item/item.json

Fix the demo for the schools (#8879)
A	erpnext/demo/data/assessment_criteria.json
A	erpnext/demo/data/grading_scale.json
M	erpnext/demo/data/item_schools.json
M	erpnext/demo/data/program.json
A	erpnext/demo/data/student_batch_name.json
M	erpnext/demo/demo.py
M	erpnext/demo/setup/education.py
M	erpnext/demo/user/schools.py
M	erpnext/schools/api.py

Lint and fix JS files
M	erpnext/accounts/doctype/account/account.js
M	erpnext/accounts/doctype/account/account_tree.js
M	erpnext/accounts/doctype/asset/asset.js
M	erpnext/accounts/doctype/asset/asset_list.js
M	erpnext/accounts/doctype/asset_movement/asset_movement.js
M	erpnext/accounts/doctype/bank_guarantee/bank_guarantee.js
M	erpnext/accounts/doctype/cost_center/cost_center.js
M	erpnext/accounts/doctype/fiscal_year/fiscal_year.js
M	erpnext/accounts/doctype/journal_entry/journal_entry.js
M	erpnext/accounts/doctype/monthly_distribution/monthly_distribution.js
M	erpnext/accounts/doctype/payment_entry/payment_entry.js
M	erpnext/accounts/doctype/payment_reconciliation/payment_reconciliation.js
M	erpnext/accounts/doctype/period_closing_voucher/period_closing_voucher.js
M	erpnext/accounts/doctype/pos_profile/pos_profile.js
M	erpnext/accounts/doctype/pricing_rule/pricing_rule.js
M	erpnext/accounts/doctype/purchase_invoice/purchase_invoice.js
M	erpnext/accounts/doctype/purchase_taxes_and_charges_template/purchase_taxes_and_charges_template.js
M	erpnext/accounts/doctype/sales_invoice/sales_invoice.js
M	erpnext/accounts/page/pos/pos.js
M	erpnext/accounts/report/accounts_payable/accounts_payable.js
M	erpnext/accounts/report/accounts_payable_summary/accounts_payable_summary.js
M	erpnext/accounts/report/accounts_receivable/accounts_receivable.js
M	erpnext/accounts/report/accounts_receivable_summary/accounts_receivable_summary.js
M	erpnext/accounts/report/bank_clearance_summary/bank_clearance_summary.js
M	erpnext/accounts/report/bank_reconciliation_statement/bank_reconciliation_statement.js
M	erpnext/accounts/report/budget_variance_report/budget_variance_report.js
M	erpnext/accounts/report/item_wise_purchase_register/item_wise_purchase_register.js
M	erpnext/accounts/report/item_wise_sales_register/item_wise_sales_register.js
M	erpnext/accounts/report/payment_period_based_on_invoice_date/payment_period_based_on_invoice_date.js
M	erpnext/accounts/report/purchase_invoice_trends/purchase_invoice_trends.js
M	erpnext/accounts/report/purchase_register/purchase_register.js
M	erpnext/accounts/report/sales_invoice_trends/sales_invoice_trends.js
M	erpnext/accounts/report/sales_register/sales_register.js
M	erpnext/buying/doctype/purchase_order/purchase_order.js
M	erpnext/buying/doctype/purchase_order/purchase_order_list.js
M	erpnext/buying/doctype/request_for_quotation/request_for_quotation.js
M	erpnext/buying/doctype/supplier/supplier.js
M	erpnext/buying/doctype/supplier_quotation/supplier_quotation.js
M	erpnext/buying/page/purchase_analytics/purchase_analytics.js
M	erpnext/buying/report/purchase_order_trends/purchase_order_trends.js
M	erpnext/buying/report/quoted_item_comparison/quoted_item_comparison.js
M	erpnext/crm/doctype/lead/lead.js
M	erpnext/crm/doctype/opportunity/opportunity.js
M	erpnext/crm/report/campaign_efficiency/campaign_efficiency.js
M	erpnext/crm/report/minutes_to_first_response_for_opportunity/minutes_to_first_response_for_opportunity.js
M	erpnext/hr/doctype/appraisal/appraisal.js
M	erpnext/hr/doctype/attendance/attendance.js
M	erpnext/hr/doctype/employee_attendance_tool/employee_attendance_tool.js
M	erpnext/hr/doctype/employee_loan/employee_loan.js
M	erpnext/hr/doctype/expense_claim/expense_claim.js
M	erpnext/hr/doctype/leave_allocation/leave_allocation.js
M	erpnext/hr/doctype/leave_application/leave_application.js
M	erpnext/hr/doctype/leave_control_panel/leave_control_panel.js
M	erpnext/hr/doctype/offer_letter/offer_letter.js
M	erpnext/hr/doctype/process_payroll/process_payroll.js
M	erpnext/hr/doctype/salary_slip/salary_slip.js
M	erpnext/hr/doctype/salary_structure/salary_structure.js
M	erpnext/hr/doctype/upload_attendance/upload_attendance.js
M	erpnext/hr/doctype/vehicle_log/vehicle_log.js
M	erpnext/hr/page/team_updates/team_updates.js
M	erpnext/hr/report/salary_register/salary_register.js
M	erpnext/maintenance/doctype/maintenance_schedule/maintenance_schedule.js
M	erpnext/maintenance/doctype/maintenance_visit/maintenance_visit.js
M	erpnext/manufacturing/doctype/bom/bom.js
M	erpnext/manufacturing/doctype/production_order/production_order.js
M	erpnext/manufacturing/doctype/production_planning_tool/production_planning_tool.js
M	erpnext/manufacturing/page/production_analytics/production_analytics.js
M	erpnext/manufacturing/report/bom_stock_report/bom_stock_report.js
M	erpnext/manufacturing/report/production_order_stock_report/production_order_stock_report.js
M	erpnext/projects/doctype/project/project.js
M	erpnext/projects/doctype/timesheet/timesheet.js
M	erpnext/public/js/account_tree_grid.js
M	erpnext/public/js/communication.js
M	erpnext/public/js/controllers/accounts.js
M	erpnext/public/js/controllers/buying.js
M	erpnext/public/js/controllers/taxes_and_totals.js
M	erpnext/public/js/controllers/transaction.js
M	erpnext/public/js/payment/payments.js
M	erpnext/public/js/purchase_trends_filters.js
M	erpnext/public/js/sales_trends_filters.js
M	erpnext/public/js/setup_wizard.js
M	erpnext/public/js/shopping_cart.js
M	erpnext/public/js/sms_manager.js
M	erpnext/public/js/stock_analytics.js
M	erpnext/public/js/utils.js
M	erpnext/public/js/utils/item_selector.js
M	erpnext/public/js/utils/party.js
M	erpnext/schools/doctype/assessment_plan/assessment_plan.js
M	erpnext/schools/doctype/assessment_result/assessment_result.js
M	erpnext/schools/doctype/course_schedule/course_schedule.js
M	erpnext/schools/doctype/course_scheduling_tool/course_scheduling_tool.js
M	erpnext/schools/doctype/fee_structure/fee_structure.js
M	erpnext/schools/doctype/fees/fees.js
M	erpnext/schools/doctype/fees/fees_list.js
M	erpnext/schools/doctype/program_enrollment/program_enrollment.js
M	erpnext/schools/doctype/program_enrollment_tool/program_enrollment_tool.js
M	erpnext/schools/doctype/student_applicant/student_applicant.js
M	erpnext/schools/doctype/student_attendance_tool/student_attendance_tool.js
M	erpnext/schools/doctype/student_group_creation_tool/student_group_creation_tool.js
M	erpnext/schools/report/absent_student_report/absent_student_report.js
M	erpnext/schools/report/student_batch_wise_attendance/student_batch_wise_attendance.js
M	erpnext/schools/report/student_monthly_attendance_sheet/student_monthly_attendance_sheet.js
M	erpnext/selling/doctype/installation_note/installation_note.js
M	erpnext/selling/doctype/quotation/quotation.js
M	erpnext/selling/doctype/sales_order/sales_order.js
M	erpnext/selling/doctype/sales_order/sales_order_list.js
M	erpnext/selling/page/sales_analytics/sales_analytics.js
M	erpnext/selling/report/quotation_trends/quotation_trends.js
M	erpnext/selling/report/sales_order_trends/sales_order_trends.js
M	erpnext/selling/report/sales_person_target_variance_item_group_wise/sales_person_target_variance_item_group_wise.js
M	erpnext/selling/report/sales_person_wise_transaction_summary/sales_person_wise_transaction_summary.js
M	erpnext/selling/report/territory_target_variance_item_group_wise/territory_target_variance_item_group_wise.js
M	erpnext/selling/sales_common.js
M	erpnext/setup/doctype/company/company.js
M	erpnext/setup/doctype/email_digest/email_digest.js
M	erpnext/setup/doctype/global_defaults/global_defaults.js
M	erpnext/stock/dashboard/item_dashboard.js
M	erpnext/stock/doctype/batch/batch.js
M	erpnext/stock/doctype/delivery_note/delivery_note.js
M	erpnext/stock/doctype/item/item.js
M	erpnext/stock/doctype/landed_cost_voucher/landed_cost_voucher.js
M	erpnext/stock/doctype/material_request/material_request.js
M	erpnext/stock/doctype/packing_slip/packing_slip.js
M	erpnext/stock/doctype/purchase_receipt/purchase_receipt.js
M	erpnext/stock/doctype/stock_entry/stock_entry.js
M	erpnext/stock/doctype/stock_entry/stock_entry_list.js
M	erpnext/stock/doctype/stock_reconciliation/stock_reconciliation.js
M	erpnext/stock/report/batch_item_expiry_status/batch_item_expiry_status.js
M	erpnext/stock/report/batch_wise_balance_history/batch_wise_balance_history.js
M	erpnext/stock/report/delivery_note_trends/delivery_note_trends.js
M	erpnext/stock/report/itemwise_recommended_reorder_level/itemwise_recommended_reorder_level.js
M	erpnext/stock/report/purchase_receipt_trends/purchase_receipt_trends.js
M	erpnext/stock/report/stock_balance/stock_balance.js
M	erpnext/support/page/support_analytics/support_analytics.js
M	erpnext/templates/includes/cart.js
M	erpnext/templates/includes/product_list.js
M	erpnext/templates/includes/product_page.js
M	erpnext/templates/pages/projects.js

Financial Statements Button translateabled (#9032)
M	erpnext/public/js/financial_statements.js

Update code to fix issue #erpnext WN-SUP25349 : ValueError: max() arg is an empty sequence. (#9025)
M	erpnext/accounts/doctype/asset/asset.py

[minor] removed the {next} for last page (#9002)
M	erpnext/docs/user/manual/en/stock/item/item-valuation-fifo-and-moving-average.md

Change modified time
M	erpnext/manufacturing/doctype/bom/bom.json

Remove Role 'All' from BOM
M	erpnext/manufacturing/doctype/bom/bom.json

Minor change: Alert to msgprint (#8966)
M	erpnext/stock/doctype/material_request/material_request.js

Correction of the digest template (#8992)
M	erpnext/setup/doctype/email_digest/templates/default.html

Added a reference of Sales Invoice in Serial No (#8855)
M	erpnext/accounts/doctype/sales_invoice/sales_invoice.js
M	erpnext/accounts/doctype/sales_invoice/sales_invoice.py
M	erpnext/accounts/doctype/sales_invoice/test_sales_invoice.py
M	erpnext/patches.txt
A	erpnext/patches/v8_0/set_sales_invoice_serial_number_from_delivery_note.py
M	erpnext/stock/doctype/serial_no/serial_no.json

add milestone field
M	erpnext/projects/doctype/task/task.json

[rename] zh-tw -> zh-TW
R100	erpnext/translations/zh-tw.csv	erpnext/translations/zh-TW.csv

View Attachments in portal (#8830)
M	erpnext/shopping_cart/doctype/shopping_cart_settings/shopping_cart_settings.json
M	erpnext/shopping_cart/doctype/shopping_cart_settings/shopping_cart_settings.py
M	erpnext/templates/pages/order.html
M	erpnext/templates/pages/order.py

Documentation for Allow Login using Mobile Number (#8918)
A	erpnext/docs/assets/img/setup/users/user-login-email.png
A	erpnext/docs/assets/img/setup/users/user-login-mobile.png
M	erpnext/docs/user/manual/en/setting-up/settings/system-settings.md
M	erpnext/docs/user/manual/en/setting-up/users-and-permissions/adding-users.md

Prompt for mandatory batch number in POS (#8928)
M	erpnext/accounts/page/pos/pos.js

link the different doctype in the school module (#8844)
M	erpnext/schools/doctype/course/course.js
M	erpnext/schools/doctype/program/program.js
M	erpnext/schools/doctype/student_attendance_tool/student_attendance_tool.js
M	erpnext/schools/doctype/student_group/student_group.js

Update lead.py (#8789)
M	erpnext/crm/doctype/lead/lead.py

Website Specification Labls should not be capitalised by default (#8798)
M	erpnext/templates/generators/item.html
```