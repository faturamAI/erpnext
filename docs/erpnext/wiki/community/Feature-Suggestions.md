_Note: This is an archived post.  To make a feature request, please go to the [Enhancement](https://discuss.erpnext.com/c/enhancement)  category on the ERPNext forums and make a new thread._<br>
***

Features Suggestions and Comments.

**Note:** Please update feature request in the correct section so that its easier to link requests to one another.

## General
- Make a provision to add lines to the head section of the main page and the generated pages as eg used by Google to verify websites
- Keyboard shortcuts!!! ;-)
- In the new July 2013 user interface, have a *condensed* theme option that makes fields closer to one another. Similar to how the current (2013-07-27) Gmail interface has settings for *comfortable*, *cozy* and *compact*.
- User wise default. On login, user will select company and fiscal in which wish to make entries. Data of companies other than selected one will be hidden.
- User should have an option to set an alignment (left, right, center) for fields.
- Ability to add new fields from Customize Form, instead of Custom Field, as it seems more intuitive.
- Unified search box that searches across tables
- Support Ticket to Lead / Opportunity
- Validation error to bring to relevant field.
- Option to save filters in records list and report builder.
- Option for multiple selection in item table of transactions.
- Renaming of address and contact master with customer and supplier name.
- Deprecate Deleting instead make something like "MAKE INACTIVE", this would be very useful and would not create errors due to validation or in calculations.
- There should be a file manager in the system since attaching 1 file in 2 transactions make the system have 2 copies of the file which unnecessarily creates duplicate files. Also the deletion of attachment should not be so easy since some attachments are very important but are easy to delete by any user even by mistake.
- Search Box in item search of forms like "Sales Order" needs to be replaced with search boxes with multiple filters
- Searching for items should be intuitive with multiple filters like in EXCEL AUTO-FILTERS. Like if for Filter A there are 3 options X,Y & Z then on selecting option X the values of other filters should be updated accordingly with only available options and not with other options like in Filter B for X there is only 1,2,3 whereas for Y there are could be 4,5,7 etc.
- Customer/Supplier should fetch automatically when create new transaction from customer/ supplier master.
- Audit Trail system using filterable "Feed" / "Activity" page.
- Ability to add restriction on a role on the basis of assigned to field. Like if I want the support team to  access a customer details only when the task is assigned to them regarding the customer then how could I do that in the current system but if I had a way of restricting the access of a customer via the ASSIGNED to field in the permissions manager then I think it could be possible.
- Multi-level authorization on signup, like my pin sent to user in SMS etc.
- Every http, https text convert to link, ex on comment section.
- Phone number convert clickable phone number, like click-to-call. (ex: on contact page): http://tools.ietf.org/html/rfc5341

#### EMail Suggestions

- Email backup link every monday.
- FROM ID field to be read-only so user won't send email from personal or other than companies id. (Sonal Ramnathkar)
- Integration with google business apps for logins and email sending.
- Auto-email to notify party in case of amended document to disregard earlier document. (Giorgio, WN-SUP02079)

#### Numerical Precision

Say I buy a bag of 100 items XYZ, for Euro 38,52. I enter the unit price as purchase price, but I am limited to 2 decimals. So one item, costing Euro 0.3852 is rounded of to 0.39. No in entering the PO/PI/PR etc The calculated price becomes Euro 39, so I introduce an error of almost half a Euro!!
Request is that more than two decimals can be used!!

#### Ability to make some Filters as default via Customize Form View

The system would become even more user friendly if the system manager could have the ability to add some default filters so that the normal users who are not very proficient with the system are able to easily enter searches.

#### Restrictions on Reports

This is a major query as we are not able to control as to which reports a User can access and which reports a user cannot access.
Let me give a scenario:
-There is a person who is there to enter sales orders and make delivery notes.
-Then he has the access to the reports like total sales and item wise details of the whole company in a snapshot and now if this person colludes with someone outside then can probably just export the report to excel and give away all the data.
-Similarly all have access to the analysis pack which is also not a desirable thing.
-Suggestion: All reports should have a Permissions Manager which should specify the type of access for a user or user group. Like some users should only have the ability to View the Reports and NOT EXPORT them and some users cannot access the reports all together.

## Accounts

- There should be an option in payment entry which will calculate different between invoice and payment value caused due to currency rate fluctuation. Same difference will be booked in pre-defined account head. Same thing is done manually at the moment.
- Automated depreciation entries.
- Export Financial Statements to Excel.
- Multiple Currency Balances.
- Print Format for Debit / Credit Notes.
- Email notification to track payables and receivables.
- Tax inclusive sales invoice, option for user to define where discount should be calculated over tax inclusive or tax exclusive rate. (Robert)

#### Item / customer / sales wise profitability report

An "extended price" list showing purchase rate, production cost rate,
(if applicable), the tax rate (or rates), the sales price, the taxes
(Vat amount), the profit (sales rate- purchase rate)/(1+vat/100), and
the profit as an % of sales rate.
I believe such a table is a crucial information for any business.

Related to this the profit of the actual sales in the trend analyser
(that allows grouping per item, customer etc) also taking into account
the "real sales price" (one may have typed over the fetched price, or
not avialble, and the discounts offered. This would give a quick
overview whether the discounts (Dogs Love It, is quite generous in
this sense, but I am not capable of seeing the profitability per
customer/sales, and as a consequence "see" that we are maybe somewhat
overgenerous)

The inclusion of one (1) more field namely, the "standard price" (or the calculated cost price) in "Itemwise Sales Register" would allow the user to easily generate and item wise and custom wise profit reports in Excel, pending availability of such functionality in ERPNext., rgds robert


Notification to Account Manager when Invoice exceed due date and still not paid:
Can we have triggers for certain events within ERPNEXT especially for aging receivables. I will for example like to be notified by email once an invoice crosses 30 days overdue. 60 days and 90 days. (Dimeji)

-- Aditya Duggal


## Sales

- System should tell me how much of my SO order has been ordered... just like it updated for %delivered and %billed..
- Discount management based on party type, geographic location, order quantity, order grand total, product category etc. It can be implemented by setting up some rules for each discount scheme.
- Ability to search customers based on City, State from address tables.
- While creating Quotation from Opportunity, prices of price list should be fetched across corresponding items.
- In SALES ORDER ITEM table, i can click on edit row and get a popup and use the keyboard to make entries. If this same popup would at the end allow for options like "UPDATE & NEXT ROW" , "UPDATE & PREVIOUS ROW" .... insert , delete etc. it will make entries into the item table a charm. 

#### POS

1.  Make the dropdown list field wider, so more info can be displayed, and also display price.
2. I have a coding scheme that works well. However, quite regular I will go into the search window, if from the droplist I cannot identify the correct  item. If a partial code is entered, an annoying “this code does not exit” window pops up, that I have to close first. This was before not the case (I believe). Remove.
3. A small + and – sign in the quantity box would make entering small quantities much faster, as compared to the present backspace, backspace, enter the number. Clicking the plus would increase quantity by one (1).
4. Quantity, price: if numerical is entered the content should be removed automatically>> so no need to clean the field first, using backspace.
5. If one knows the code by heart (as I do for frequent items) it would be quick if I cld type the code with quantity in one go. Allow the use of a special character (user defined eg #) to allow to add quantity to code. Our most sold article has code dami1. So 5 packs of dami1 wld be entered as damai1#5.


#### Customer Sales Prediction, Triggers

I am trying to find out of my existing customers who have been buying regularly and who are not, now it seems simple but I would put up the conditions which make the scenario really a challenge which I have not been able to conquer.

Some customers are large and they buy in the tune of 200,000 per month or maybe more but their order sizes are small. So these might have big number of orders of smaller values.
Some customers are only buying like 50k a month but they give order in one shot every month.
I think the customer master is missing one major ingredient here and that is: Estimated Monthly Sale field or we could have 2 fields, one for the amount of orders and the other the frequency of orders.

This/ these fields would act like triggers of Minimum  Inventory level so when a customer falls below this amount of SO then the system alerts the predefined person by email or a Task to call and find out the problem.

- The possible solution for this thing is that Customers should have 2 fields:
1. Average Expected Sales
2. Average Period

The two fields should be the driving force for email notifications or TASK creation in the Sales Person's account. For example: One customer gives orders every 3 days and his average of 3 days is 40,000 then we would have one field as 40,000 in average expected sales and the average period (in days) would be 3. So the system should check every 3 days if the average SO received from this customer is is below this value or not and if it is then it would create a TASK in the sales person's column to CALL this Customer.

(via Aditya Duggal)

## Purchase

- Option to pull items in purchase order from BOM
- Just like we have customer address and contact report, same way, we will should create report which will pull data from different doctypes supplier, address and contact in same report..
- It will be helpful to users to track all the transaction (PR/PI/Payment) against PO from a single place.
- For customers that do purchasing only when there is order. So, each purchase transaction will be tagged with some sales transaction. They need a report for checking DEALWISE profitability.
- Allow subcontract only for items with BOM
- Warehouse, reqd date to be auto selected in all rows in PO and Purchase Request.
- Supplier wise contract.

## Stock / Inventory

- When making delivery note, user should get search option where he can see all serial nos. with status = in store for selected item in selected warehouse.
- Show image in Item Master.
- Batch-wise stock level report.
- Request for Quote (RFQ) and Supplier Quotation forms.
- Report on how reserve qty is getting calculated. Some analysis on Sales Order. Also, Stock level and ledger report should be linked. Clicking on items actual qty should take me Stock ledger report to show how this figure was achieved. Same way for reserve qty also. (Tarun, Neural India)
- Table in Stock Reconciliation with fields like Item Code, Warehouse and Qty so that if you want to do a single/ small number of items' reconciliation then you need not create a CSV. Though this feature request is for table an option to add CSV should never be given away.

#### Standard Cost and Last Cost methods of Valuation

You may want to also allow the simultaneous tracking of Standard Costs and Last Costs.

- Last costs are generally more in line with current market costs.
- Standard costs allow companies to set target costs and measure variances against those standards.

Also, you may want to consider a cost roll-up feature that allows users to do mass modification of the standard cost to the last cost or average cost. I can supply a screen shot of a utility from another ERP system for this feature if you would like.

#### Improvements to Batching System

- For "batch number", you may want to add to the Help documentation that batch number = lot control number.
- For "batch number", you may want to have that auto-generated and maybe auto-enforced. In our current ERP system, lot control numbers are generated as:
    - for purchased items, the receiver number + receiver line item (example: 010221-002 means line item 002 on receiver 010221)
    - for manufactured items, the job order number of the job order that produced them (example: 20211)

"Auto-enforced" means when kitting a job with components, the user is forced to indicate the lot control number for each component on the BOM (pick list). Possibly make "auto-enforced" user set -- some companies may not want it.


## Reports

- Itemwise sales / purchase report with other charges and taxes detail
- System manager should be able to run the report to see users activities on any given date.
- Fetch reports directly into Excel
- A break-even analysis system - [See Wikipedia article](http://en.wikipedia.org/wiki/Break-even_(economics))
- Option to Delete Reports, but the right to delete a report should only with either Report Manager or System Manager.

#### Debtor / Creditor Report

We had been using ERP next for the past 1 year & found it very useful
for all our accounting purpose. We need few upgradations in your
software. Right now, we are unable to take a report for both debtors &
creditors together as we normally take out from Tally because that
report is very helpful for finalising the balances.
Request your feedback on the same.

Debtor Ledger format:

Date Party Name Bill raise Payment received Balance REMARKS
party 'A' All Transactions related to party 'A'

## Production

#### New Material Report

This is in reference to the reports generating through Production Planning.
The view of the report is being generated with total no. of stock
available in the factory, which includes STORES, WIP, SHOP FLOOR, RESERVED,
SCRAP, REJECTION, etc.
We request you to kindly make the changes in this report so that we are
able to view the stock as per the Particular WAREHOUSE TYPE.

#### Engineering Change Request

I have been trying to get to implement the ECN system which a lot of engineering companies follow but I have not been able to find a way to do that in the ERP.

What is ECN?
http://en.wikipedia.org/wiki/Engineering_Change_Notice 
It is basically a process by which a design data can be changed in a product. So in common language it means that if there is a product then the drawing of the product needs to be changed then the person wanting the change would first issue a ECR (Engineering Change Request) and this request is forwarded to the person who would pass t his ECR and it would become a ECN.

Now I have had a thought that we could attach individual drawings of each item in the item master itself but the file management system is such that there is no way to track the changes made to the file.

Is there a way to do such thing in ERP?

(via Aditya Duggal)

#### Quality Checking after manufacturing

The system should ask for a quality inspection, based on inspection criteria specified for an Item, after the item is manufactured. (Just like it happens for goods purchased)

## Website

- CAPTCHA verification to avoid unwanted people clicking mails is a must in the Contact us page.

## HR / Payroll

- Filter on Employment Type in Salary Manager
- Attendance template should not pull dates listed in holiday list master.
- Ability to upload attendance by the hour, basically there are some employees in the company who are paid by the hour and over and above the regular hours they are paid the Overtime. Currently in attendance there is only the option to put Present, Absent and Half Day but no provision to have the attendance by the hour.
- Form to post job vacancy and track applications against it.
- Provision for allowing advance payment to Employee. Also, the advance paid should get deducted from employees salary in multiple months. (Mahesh Malani)

## Projects and Timesheets

- Ability to make invoice from Timesheet
- Keep track of Timesheets yet to be billed etc.
- Mark Timesheets as billable or not-billable
- Directly enter hours (rather than start and end times) in the timesheet table
- Cost center should be auto-created on creating Project.

## Code / Model Optimization

- There is no need to save Amount in words. Wherever required, we should call amount in words function.
- Fractional Currency (for example: cents in case of USD), should be defined in Currency Master itself.
- Implement Currency Symbols, like $, ¢, £, ₹
- Restrict fieldnames from being python, js keywords.
- i18n
- Merge renaming and bulk renaming tools.

## To Dos and Calendar

- Need better integration between To Dos, Calendar, Tasks and Email like reminders prior to deadline, progress, etc.
- To Dos should have a check to show that entry in the calendar
- Support Ticket follow up on calendar
- A Calendar view of Support Ticket - showing subject on the day it was received with a link to open it. (alternative to a list view)
- Show these in calendar
  - Tasks
  - ToDos
  - Support Ticket opened
  - Support Ticket follow-up date
  - Events (set within the Calendar)
  - Project Milestones
- 3-month, 6-month, 1-year views