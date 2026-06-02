**WORK IN PROGRESS**

This document is linked to the following Frappe Issue: https://github.com/frappe/erpnext/issues/9340

## General introduction

This document aims at solving a compliance requirement that must be fulfilled for the 1st of January 2018 in France. The purpose it to fight against VAT fraud with POS systems.
As of this date, every organization owing VAT to the Fiscal Administration should use a point of sale or cash register system compliant with the following criterion:

* inalterability
* security
* data retention
* archival


The software should be either accredited by a third party accreditor or the editor/service provider can provide a certificate of compliance.

If these requirements are not fulfilled, companies will be fined 7,500€ in case of control and the software provider (even outside of France) will be fined 45,000€ + 3 years in prison if the certificate is forged/on false grounds.


Even if this document is specific to a problem applicable to France, given the scope of these requirements, these developments can only enhance the current framework and be applicable in other countries.

## Purpose of this document

In this document we will focus specifically on the chaining of all sales and payment transactions to guarantee their integrity by leaving a print.

**Legal requirements:**

_All transactions data should leave a transaction print with an cryptographic hash function._
_Best state of the art authorized algorithms are: SHA-2, SHA-3, Whirpool, Blake_
_Example of state of the art data signature algorithms : RSA-SSA-PSS, ECDSA_

_To be noted: Printing an invoice is considered a transaction and each original print should be registered as such._

_In short: all transaction data must be chained or sealed with a timestamped signature. This is true for all transactions data and all vouchers (archiving integrity is one of the requirement)._



Based on the above elements, the development can be split in several parts.


### Part 1 - Creation of a Transaction Log

The transaction log, needs to be separated from the logged document.

It should comply with the following rules:
* All doctypes should potentially be added to the transaction log
* A transaction log should never be deleted:
  * If created as a doctype, its permissions should not be modified
  * We can compromise by allowing the "Administrator" to have deletion rights (through a direct query in the DB for example, it will just mean that the software will need to be hosted by the third party guaranteeing the data integrity).
* A transaction log should capture:
  * The reference doctype
  * The name of the logged document (reference document)
  * A timestamp
  * The reference document's data or a subset of its data
  * The checksum algorithm version (for future updates)
  * A transaction hash
  * The hash of the previous transaction
  * A chaining hash


### Part 2 - Logging of all sales and payment documents

When submitted, all sales and payment transactions should be logged in the transaction log.

### Technical Details

Calling the below create_transaction_log function in on_submit method of sales_invoice.py and payment_entry.py, so whenever a sales invoice and payment entry is submitted a transaction log should be created for it with the following data.


### Part 3 - Creation of an integrity report

A report should be created to test the integrity of the chain and of the transactions.

### Technical Details for Report



****
Python Transaction Log file proposal

```python
# -*- coding: utf-8 -*-
# Copyright (c) 2017, Frappe Technologies and contributors
# For license information, please see license.txt

from __future__ import unicode_literals
import frappe
from frappe.model.document import Document
from frappe.utils import now, cint
import hashlib

class TransactionLog(Document):
def before_insert(self):
index = getcurrentindex()
self.row_index = index
self.timestamp = now()
if index != 1:
self.previous_hash = frappe.db.sql("SELECT chaining_hash FROM `tabTransactionLog` WHERE row_index = {0}".format(index - 1))
else:
self.previous_hash = self.hash_line()
self.transaction_hash = self.hash_line()
self.chaining_hash = self.hash_chain()
self.name = self.chaining_hash
self.checksum_version = "v1.0.0"

def hash_line(self):
sha = hashlib.sha256()
sha.update(str(self.row_index) + str(self.timestamp) + str(self.data))
return sha.hexdigest()

def hash_chain(self):
sha = hashlib.sha256()
sha.update(str(self.transaction_hash) + str(self.previous_hash))
return sha.hexdigest()

def getcurrentindex():
current = frappe.db.sql("SELECT `current` FROM tabSeries WHERE name='TRANSACTLOG' FOR UPDATE")
if current and current[0][0] is not None:
current = current[0][0]

frappe.db.sql("UPDATE tabSeries SET current = current+1 where name='TRANSACTLOG'")
current = cint(current) + 1
else:
frappe.db.sql("INSERT INTO tabSeries (name, current) VALUES ('TRANSACTLOG', 1)")
current = 1
return current

def create_transaction_log(doctype, document, data):
print(data)
transaction_log = frappe.get_doc({
"doctype": "TransactionLog",
"reference_doctype": doctype,
"reference_document": document,
"data": data
}).insert(ignore_permissions = True)
```