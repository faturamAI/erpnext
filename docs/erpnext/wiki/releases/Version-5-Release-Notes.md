## Version 5 Release Notes

### Fresh New Look

- Cleaner lines
- Simpler Menus
- Indicators

### Item Variants

Item Variants feature allows you to auto-generate unique item code for the each variant of a template item.

#### Scenario:

A design of t-shirt is available in two sizes and two colours.

<table>
<tr>
<td>Template Item </td> 
<td>T-Shirt</td>
</tr>
<tr>
<td>Colours</td>
<td>Blue (BL) and White (WT)</td>
</tr>
<tr>
<td>Sizes</td> 
<td>Small (SM) and Medium (MD)</td>
</tr>
</table>

- Templates and Variants

To create variant items, you should first define a Template Item. In the template item, all possible variants will be listed. Based on the variants defined in the Template Item, unique Item will be generated for each item variant.

![Item Variants Licecap](http://i.imgur.com/TgzMASe.gif)

- Item Attributes

Item Attributes is the master where you can set attributes (e.g.: Size, Colour) based on which variants items will be created. To setup Item Attributes master, go to:

Stock > Setup > Item Attributes

Item Attribute master for Size and Colour will be auto-created. Let's take an example of Size to learn how Item Attribute function.

![Item Attribute Variant](http://i.imgur.com/PDm5TlO.png)

Considering a scenario, Item Codes generated for the variant items will be:

   T-Shirt-001-BL-SM  
   T-Shirt-001-BL-MD  
   T-Shirt-001-WT-SM  
   T-Shirt-001-WT-MD

In the Attribute master, you can also set preference following which Item Code for the variant items will be generated.

- Automatic updation of variants

On updating template item, respective variants item will be auto-updated. 

![Template to Variant Update](http://i.imgur.com/GmNhGII.gif)

Item Price record created for the Template Item will be applicable for all the Variant Items.

In the sales and purchase transactions, only variant items will be selectable. But on the website, only template item will be published. Customer will find option to define value for the attributes. Based on their selection, variant item will be updated in the sales transaction.

### Print Format Builder

Print Format builder is a tool to create custom print formats in ERPNext, with any coding required. You can add fields in the print format by just drag and drop. Also you can define section, and columns breaks under each section. To create new Print Format, go to:

    `Setup >> Printing and Branding >> Print Format`

- Drag and Drop

![Drag and Drop](http://i.imgur.com/hz8IRDS.gif)

- Embed custom HTML, Templating

You can also insert Custom HTML in the print format generated form Print Format Builder Tool.

![Custom HTML]()

- Select grid columns

For documents which has child table, like Item table in the Sales Order, you simply need to check columns/fields of the item table which will be shown in the print format.

![Print Format Item](http://i.imgur.com/KT1TPMg.gif)

### Multiple Root Chart of Accounts

Each country has unique accounting system, and a Chart of Account master to comply to it. ERPNext will be offering a preset Chart of Account based company's country.

In the Chart of Account master, root account, sub-ledgers and ledgers will be as per countries standards. [You can welcome to contribute Chart of Account of your country more robust](https://discuss.frappe.io/t/help-needed-country-wise-chart-of-accounts/4154).

- Default Chart of accounts for different countries

Following is the Chart of Account for a company in the USA. It has six root account, unlike other countries where Chart of Account has only four root accounts.

![Country wise COA](http://i.imgur.com/MmWMT8V.png)

### Capacity Planning

Capacity Planning feature will allow you to track and allocate production job on the specific Workstation. For a workstation, they will be able to see queue of production jobs which needs to be executed, and plan for the upcoming production jobs accordingly.

- Operations in Production Order

Bill of Material has Operations and Workstations listed through which raw-material items are processed. When Production Order is created, Operations details will be fetched from BOM of the manufacturing Item.

![Operations in Production Order](http://i.imgur.com/0Q4pZOG.png)

Operations details in the Production Order will allow you to:

**Work Station Allocation:**

Define specific Workstation for each Operation. With this, system will be able to queue production jobs for that Workstation.

![Workstations in Operations](http://i.imgur.com/y9Q13L0.png)

**Costing at each Operation:**

To get actual operations cost, user should update actual time spent on each Workstation. To track actual time spent on the Workstation, user will be able to create Time Log against each operation.

![Operations Time Tracking]()

- Workstation hours and holidays

You will be able to define working hours and Holiday List for each Workstation. This will be taken into account while allocating production job at the Workstation.

![Workstation working hours](http://i.imgur.com/huQhVKD.png)

- Automatic Creation of Time Logs on Workstations

On Submission of Production Order, Time Logs will be automatically created for each operation. User will be able to update actual start and end time in that Time Log.

![Time Log against Production Order]()

- Simplified Stock Entry

Stock Entry has new Purposes being introduce called "Material Transfer against Manufacturing". This will help user separate normal Material Transfer entry and Material Transfer entry against Manufacturing.

![Stock Entry Purpose](http://i.imgur.com/xdYocfo.png)

BOM details section has been moved about the Item table for better navigation within Stock Entry form. This section's visibility will be based on Purpose selected in the Stock Entry.

![Stock Entry](http://i.imgur.com/N291MKe.gif)

### Sharing

Share feature in ERPNext will allow one user to share specific document (any master or transaction) with another users. Once document is shared with any user, s(he) will be able to access it, even if doesn't have permission on that document.

![Share Documents](http://i.imgur.com/pMZ5DV6.png)

- Easy to set permission rules

When share document with any other users, you will be able to specify following permission on it.

1. Read: This will only let user read that document, but not edit it.
2. Write: This will allow user to edit values in the document.
3. Share: This will allow user to share same document with other users as well.

### Starring

List view of documents will allow starring each document. You can also filter list view on starred documents.

![Starring](http://i.imgur.com/7U8SmUP.gif)

### Email Account

Email Accounts feature allows you to pull emails from specific email id, and have it appended in the specific in the specific form in the ERPNext. In the earlier version, this feature was restricted only for the few documents, like Lead and Support Ticket. In this version, you can add as many incoming and outgoing email accounts as needed, and have it appended in the form you prefer.

Let's consider an example to learn how Email Accounts work. I need all the emails received on john.smith@example.com to be pulled in ERPNext, and appended to Contact master. Following is how Email Account should be setup to achieved this.

![Email Account](http://i.imgur.com/nQvrDpL.png)

For each Email Account, you can mention incoming and outgoing email gateway, Email Signature and Auto-reply.

### Reply via email

- Capture replies from customers, contacts in the timeline via (reply to)

Using Email Accounts feature, you can have messages received on an email appended into specific document of ERPNext. You will revert to that message from ERPNext itself. With this, you will have complete email thread managed in the ERPNext.

![Sending email communication GIF](http://i.imgur.com/nT28Etm.gif)

- EMail notifications for all participants

If email sender marked same emails to other people as well, your reply will also be sent to all the email id's in that thread.

### Document Timeline

Each document will have a Timeline. It will list events as it happened over a specific document. Timeline will capture events like creation, approval of document, to whom it was email, replies from the party, comments and lot more.

![Timeline](http://i.imgur.com/nujYgGE.png)

- Integrated view of document communication and history

### Renaming and re-organizing

This upgrade includes lots of form renaming and re-organization of fields within a form.

- New Module CRM

Considering a familiarity among the audience about customer relationship management application, we have added new CRM module. This module will have form and reports moved from the selling module only.

![CRM Module Home](http://i.imgur.com/2C3Tn5L.png)

Earlier Selling module contained all the feature of CRM module as well. In this version, Lead and Opportunity forms has been taken out from Selling module, and placed under CRM module. Other masters like Customers, Address and Contact master will be share among both the modules.

![CRM Module home page](http://i.imgur.com/LK6nI2Z.png)

- Ticket to Issue

Support Ticket form in the Support module will now be called Issue.

- Customer Issue to Warranty Claim

Earlier Customer Issue and Support Tickets functioned almost the same way. We have renamed Customer Issue to Warranty Claim form. We believe this title suits more with functionalities offered in the Warranty Claim/Customer Issue.

- Cleaner Stock Reconciliation

In the previous version, item's stock and valuation details could only be imported from spreadsheet file. Now you will be able to select item, and enter its Qty and Rate details in the New Stock Reconciliation Form itself.

![Stock Reconciliation](http://i.imgur.com/RjpkjHT.gif)

Also, it will allow user to select all the items in the specific Warehouse in the New Stock Reconciliation, and update quantity and value details in the form itself.

![Stock Reconciliation items](http://i.imgur.com/l93yEFB.gif)

- Renaming of child table fields

(check with Nabin)

### Multi-currency

In the sales cycle, if tax was included in the basic rate of an item, or discount amount was applied, there were not fields which will indicate revised selling rate of an item. In this version, new fields has been added which will preview Item's Rate and Amount exclusive of taxes and Discount amount as well as exclusive of taxes and discount amount.

1. Item Rate inclusive of Tax and Discount amount

![Item Rate and Net Rate](http://i.imgur.com/VRPp3q0.png)

2. Item Rate Exclusive of Tax and Discount amount

![Item Amount and Net Amount](http://i.imgur.com/Q92XUB6.png)

3. Net Total

![Totals](http://i.imgur.com/r5Q77vK.png)

- Better calculations in multi currency

**Multi-Currency in Taxes and Charges table**

In the earlier version, taxes and other charges could be entered only in the Company Currency. Now you will be able to add it in the Customer Currency as well. Also you will get tax amount in the Customer Currency as well as in the Company Currency. Following are the example of 5% VAT applied on items.

![taxes Currency](http://i.imgur.com/LhFgQl2.png)

### Discount Amount

Discount Amount is amount deducted from Net Total or Grand Total of an order. Earlier version offer applying Discount Amount only on the Grand Total. In this version, you can select if you need to apply Discount on the Net Total or on Grand Total. Discount Amount will be entered in the Customer Currency. The same will be auto-calculated in the Company Currency.

![Discount Amount](http://i.imgur.com/FpmRDN3.png)

### Improved Translations

- Thanks to the community!
Allocated to @pdvyas

### Buying cycle enhancement

Following are the feature which were available only in the sales transactions, now extended to purchase transactions a well.

- Inclusive Tax

This will allow you to enter tax inclusive rate of an item, and have system back-calculate tax exclusive rate.

- Discount amount on both net total and grand total

### Party Model

The earlier version of ERPNext created unique accounting ledger for the each customer and supplier. This accounting ledger was used to maintain account balance, and track receivable from Customer, payable towards supplier, and advance payment entries to them. 

In this version, as per the party model, separate accounting ledger will not be created for each Customer and Supplier. Instead a common accounting ledger will be used for all the customers. Same way, for the suppliers as well. After saving Customer or Supplier, you will find a table to specify default Receivable or Payable account, based on Company.

![Customer Default Receivable](http://i.imgur.com/0Dp8Us8.png)

Though there will be no separate accounting ledger, still you will continue to access all the reports which were earlier based on customer and supplier's account balance, like General Ledger, Account Receivable, Account Payable etc.

### Updates to Project Module

- Milestone is now Task

In the earlier version, Project master was maintained in the following pattern.

  * Project   
    * Milestones  
       * Task 1  
       * Task 2  
       * Task 3  

In this version, you will find that Projects will not have milestones. Milestones has been deprecated considering it was not utilized in project planning and reporting. Hence the current structure of the Projects will be:

  * Project  
      * Task 1  
      * Task 2  
      * Task 3  

- Easy entry table for tasks in project

In the Project master, you will find Task table. This will allow you to add new Task for the Project, while still on the Project master. Also if will provide all the details about the Project, and its relative Tasks at one glance.

![Project Task](http://i.imgur.com/F2eKDE8.gif) 

### Ability to Block Users from Modules

Check in User, you can now check / uncheck modules you want to give access to. Standard permission rules on DocTypes will still apply