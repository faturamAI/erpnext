## Separating Modules from ERPNext to New Apps

As we announced at the last year’s ERPNext Conference, we broke the monolith architecture of ERPNext in version 14 and separated out the following modules into new apps.

- [Healthcare](https://github.com/frappe/health)
- [Hospitality](https://github.com/frappe/hospitality)
- [Non-Profit](https://github.com/frappe/non_profit)
- [Education](https://github.com/frappe/education)
- [Agriculture](https://github.com/frappe/agriculture)
- [HR and Payroll](https://github.com/frappe/hrms)
- [Datev Integration](https://github.com/alyf-de/erpnext_datev)
- [Germany Localisation](https://github.com/alyf-de/erpnext_germany)
- [E-commerce Integration](https://github.com/frappe/ecommerce_integrations)

**How does this change affect you?**

If you are currently not using any of these modules, this change won’t affect you.

However, if you are using any of these modules, when you upgrade to version 14, you will have to **install the relevant app** on your bench.

From the user's point of view, it won’t make any difference, there will be **no loss of functionality**.

If you want to raise any new issues or pull requests, you will have to raise them on the respective repository instead of raising them on the ERPNext repository.

### Moving India taxation to the India Compliance app

We have moved all the India Taxation and Compliance features from ERPNext to a separate app called [India Compliance](https://github.com/resilient-tech/india-compliance) which will be maintained primarily by [Resilient Tech](https://www.resilient.tech/).

Except for the breaking changes listed on [discuss.erpnext.com](https://discuss.erpnext.com/t/proposed-breaking-changes-to-india-specific-features/87025) all the other functionalities are expected to work as they do now. Patches have been put to take care of other changes.

In order to continue the E-Invoicing feature, users will have to subscribe to paid in-app service, your current API credentials won’t be functional along with this app.

## New Subcontracting module

Until version 13, the subcontracting feature was managed via the Standard Buying cycle. But in version 14, we have introduced a new module **Subcontracting** to manage the functionality. We have refactored the entire workflow and introduced two new documents called Subcontracting Order and Subcontracting Receipt.

For the existing users, we also kept the old workflow which they can use to complete the open subcontracting Purchase Orders. But for the new subcontracting orders, they need to follow the new workflow (PO → Subcontracting Order → Subcontracting Receipt).

## Payment Ledger

In version 14, we have introduced a new document **Payment Ledger** to maintain the links between the Invoices and Payment Entries. Earlier we used to store the information (_Against Voucher Type_ and _Against Voucher_) inside the GL Entry document, which was a bottleneck for the immutability of the GL Entries. It will also improve the performance of the Payment Reconciliation and execution time of Accounts Receivable/Payable reports.

We still did not remove that information from the GL Entry document, but we will remove those fields after a few months. Hence, if you made (are going to make) any report/feature using that information, please implement that using the new Payment Ledger.

## CRM Enhancements

We have done a lot of enhancements in the CRM module. As communications and activities are the most important functionalities of CRM, we have introduced dedicated tabs for Activities and Notes. We have also added a new document called Prospect to maintain the information of the organization. This document shows all the related leads, opportunities and communications in a single place.

In this process, we also made following breaking changes.

- Removed **Next Contact Date**, **Next Contact By** and **Ends On** fields from Lead and Opportunity. Now, it will be managed by new **Events** functionality. Based on existing data, we have created Events where *Next Contact Date* was set within the last one month.
- Renamed **designation** field to **job_title**.
- Renamed **converted_by** field to **opportunity_owner**.
- Lead will be **disabled** automatically after it is converted to an Opportunity.

## Cost Center Allocation

Using this feature the GL Entry against a cost center can be split against multiple cost centers. In the Cost Center Allocation document, you can define allocation percentages of the child cost centers. Based on this allocation, the system posts multiple GL Entries against each cost center.

In version 13, we have a feature called [Distributed Cost Center](https://docs.erpnext.com/docs/v13/user/manual/en/accounts/distributed-cost-center) using which we can define the allocation percentages between multiple cost centers. Based on the allocation, we used to get the multiple financial reports based on the distribution, but it had no effect in the actual GL Entries.

It has certain drawbacks, like it does not take care of changes in the distribution over time. In the real world, cost center allocation keeps changing over time and based on updated allocation the system should book income/expenses against it, it should not be calculated run-time.

We have added a patch to migrate the existing data which will create Cost Center Allocation records based on the existing distributions.

## Naming Series

We have removed Naming Series tool from ERPNext and added the same functionality in the frappe framework named [Document Naming Settings](https://docs.erpnext.com/docs/v14/user/manual/en/setting-up/settings/document-naming-settings).