#### Permissions

##### Custom DocPerm

In the earlier version of ERPNext, customization made using Role Permission Manager was updated in the doctype masters itself. This doesn't allow us to update default permissions of the Doctype from a backend. To resolve this, we have introduced a feature Custom DocPerms. Now, all your permissions preferences defined from Role Permission Manager will be saved as a Custom DocPerms.

##### Dedicated roles for Report and Page

Till now, permission on reports was assigned based on permissions on the Doctype that report was based. There was no option to define roles and permission for the report and pages specifically. In version 8, you will be able to define permissions for each Report and Page master as per your requirement.

#### Kanban View

Kanban Board offers yet another view of documents. It allows you to identify a field based on which documents will be categorized and viewed together. For example, Task has Status field. If Kanban Board is created for Task, based on the Status field, then following is what you get.

![Kanban Board](http://ultraimg.com/images/2017/03/07/pRBF.png)

Kanban Board gives you the flexibility to update Task status from Kanban Board itself. Also, you can create Custom Kanban Board as per your preference. For more details on Kanban Board, check the following link.

https://frappe.io/blog/erpnext-features/kanban-board-for-erpnext

#### Customer Feedback

Feedback is a very valuable information to any company as it provides with insight that can be used to improve the quality of the services. We have added a Feedback feature that will allow you to ask a customer to rate your service. You can configure Feedback Trigger, just like we setup an Email Alert. Customer's Feedback will be updated in the relevant. You can also check Feedback Rating report for daily average rating and trend.

https://medium.com/@mbauskar/feedback-feature-for-frapp%C3%A8-erpnext-e733f222f357#.3xx7lljlg

We are testing this feature internally on Issues. Hence you if receive a feedback request against an Issue, please share your experience by responding to it.

#### Employee Loan

This feature enables a company to manage employee loans. Employees can request loans, which are then reviewed and approved. For the approved loans, repayment schedule for the entire loan cycle can be generated and automatic deduction from salary can also be set up.

https://frappe.io/blog/erpnext-features/more-enhancements-in-payroll-and-employee-loan-management

#### Global Search

Now the Awesome Bar of ERPNExt is not just a tool for quick navigation. We have made a lot more powerful by adding Global Search feature. You can search anything in ERPNext from awesome bar.

#### Multiple UOMs in Selling

Currently, you could create sales transactions for an item in its stock UoM only. But now, you can have different UoM for selling an item. For instance, if you have a pencil for an item, then you can store it in boxes, and sell in pieces. This feature was already available in the purchase cycle, and not extended to the transactions in sales side.

#### Accrual system in Salary

Paying Employee is a liability on the Company. Currently, you can only use HR module of ERPNext to process Employee salaries. But there was no option to update payables before hand. This feature will allow you to update payable for the salary which will have an impact on the relevant liability account. When salary is actually paid, then liability account's balance will be reduced and salary expense will be booked.

#### Accrual Accounting for Expense Claims

Just like salaries, you will be able to update payable for the Expense Claims as well. Once Employee is paid, knock-off payable account against an expense account.

#### Document Versioning

The feature of document versioning will help in maintaining a log of all the changes made on a document, how made it, and at what time.

#### Delete and Restore

In the earlier version of ERPNext, the deletion was a permanent action. Now, you can restore a deleted document as well.

#### New Calendar

Get a more crisp view of calendar and events.

#### Assessment Module

Student Assessment is very important to track student's progress. You can define assessment rules in your ERPNext account and create Student Assessment record.

#### POS
	
#### BOM Web view

#### Summernote Text Editor

#### Image view of documents

#### Export report in Excel format

#### Newsletter Enhancements
	- Attachments
	- multiple email groups
	- Optional unsubscribe link

#### Production Analytics Report

#### Half Day Leave Application

- Get valuation rate from Item while not found based on SLE
- get items from material requests based on possible supplier
- Student attendance enhancements
	- Student Monthly Attendance Sheet
- Optimization to reduce GLE reposting time for future stock transactions
- Attendance validation in Leave Application
- replace autocomplete with awesomplete

#### Email Inbox