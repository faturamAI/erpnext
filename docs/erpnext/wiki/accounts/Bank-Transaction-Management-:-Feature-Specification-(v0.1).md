## Introduction
The aim of this feature is to manage all the erpnext transactions related to bank account easily. This includes creating and updating payment entries, mapping payment entries to invoice, mapping payment entries to transactions in bank statement.

## Usecases
1. **Reconcile existing payment entries**

A payment entry has already been made in the erpnext, however it is not mapped to any specific invoice. This will keep the payment entry as unallocated and doesn't tell whether a invoice has been paid or not. By mapping the payment entry to invoice, we can reconcile the payment entry and keep invoice status up-to-date

2. **Create payment entries based on the bank transactions**

It is often difficult and laborious to create a payment entry every time we make/receive payments. Often, the date of actual transaction may not match the payment entry date. An alternative way to manage payments would be to create payment entries from bank statement on daily/weekly basis. The system should allow importing bank statements and create payments entry automatically based on the bank transaction.

3. **Create journal entries based on the bank transactions**

In addition to payment entries, bank transactions will also contain various transactions that results in journal entries like cash withdrawal, bank charges, interest etc. It is very beneficial to create the joural entries automatically based on the bank transactions.

## Feature Design
### Import Statements
This feature is designed to implement it in phases to improve the usability. Ideally we should provide a mechanism to connect to the bank account directly, which should retrieve the statements automatically. Once the statement transactions are imported, we should examine each one of them and handle them appropriately. It isn't very clear whether all the banks provide an easy way of importing the statements via some API that ERPNext could use. More work needs to be done in this area to find a good way of connecting to bank and importing the statements automatically. So this specification only deals with the second stage where it assumes the statements are already imported in csv format manually.

### Handle Statement Format
It is unlikely that all the banks would generate the statements in the same format. However it is assumed that all of them will be able to provide necessary information in csv format. The required information elements are:
1. Transaction Date
2. Transaction Description
3. Debit/Credit amount
So the implementation provides a mapping doctype from standard expected format to actual format. This should be created for each bank where transaction header doesn't match the default description used by ERPNext

### Identify transactions automatically
Majority of the bank transactions will have customer/supplier details in the transaction description, so it isn't very difficult to map the transaction to supplier/customer automatically. However it very likely to fail in certain cases. The system should self-learn those mappings by creating a doctype for mapping transaction to supplier/customer/expense account.

### Statement management process
1. On uploading the bank statement, retrieve all the transactions and automatically map the transaction to a particular supplier/customer/expense account
2. Manually fix any entries that has the wrong mapping and save the mappings for future management
3. Match the transactions to existing payment/journal entries and display the invoices for reconciliation
4. Update invoices that are not mapped properly
5. Create new payment/journal entries for new transaction
6. Reconcile/submit payment/journal entries

### Draft Statement Management Process
1. 