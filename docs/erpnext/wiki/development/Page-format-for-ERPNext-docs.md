# Sample DocType (DocType name, H1)
(SEO tags, meta description etc)
```
---
title: <Title of the page>
add_breadcrumbs: 1
show_sidebar: 0

metatags:
 description: <A line or two describing the feature briefly.>
 keywords: <feature name>, <related words>, frappe, erpnext new features, erp, open source erp, free erp, security
---
```

**A one line definition explaining the master/transaction in bold.**

Paragraph(s) which contain a brief introduction to the doctype, and what it's used for. 
Add an example/scenario/use case to explain the feature.

(Navigation) To access Sales Order, go to:
> Home > Module Name > Workspace Name > Page Name

## 1. Prerequisites (H2)
(add only where applicable, these will links)

Before creating and using sampledoctype it is advised to create the following first:
* Document 1
* Document 2

## 2. How to create Sample (H2)
This section will contain the steps to create the doctype.

1. Go to the sampledoctype list, click on New.
1. Enter xyz, select abc in this field (mandatory fields) with basic explanation of the fields.
1. Save/Submit/both. (Note that only transactions are submittable documents, masters can only be saved)

### 2.1 Sub-section for alternate ways to create. (H3)
There are multiple ways to create certain doctypes, add subsections for those alternate methods. Skip if not present.

### 2.2 Additional Options when creating a sampledoctype
There may be additional fields/checkboxes that aren't mandatory or a part of 'features', list them here.

### 2.3 Statuses
A transaction/document may have multiple statuses. For example, a Sales Invoice can have statuses like Draft, Paid, Unpaid, etc. List out the statuses and explain what they mean.

## 3. Features (H2)
### 3.1 Feature 1 (H3)
### 3.2 Feature 1 (H3)
...and so on.
These sub sections will list out the various features a doctype offers other than the mandatory fields required to save the doctype. These are usually seen under different sections below the first set of fields and can be expanded by clicking on them. For example: some additional fields/features for the Item doctype would be: Description, Inventory, Auto Re-order etc.

> Tip: Indent an image/paragraph by a tab / 4 spaces to continue a numbered list below it.
> To link to a specific heading in the page, the link should be like this: /docs/user/manual/en/stock/item#26-serial-numbers-and-batches (click on the `#` symbol next to the heading on the webpage.

### 3.x After Submitting
After submitting a sampledoctype, you can perform the following actions:
(These can be creating new doctypes from this doctype)

* doctype 1
* doctype 2
* doctype 3

[Add screenshot displaying the dashboard after saving submitting]

## 4. Other cases
If there are any additional actions that can be performed with this document, they go here. For example, in a Payment Entry, there is Multi Currency Payment Entry, Internal Transfer, etc.

## 5. Related Topics (H3)
1. This will be a list of related topics (links) from the manual.
2. They can be links to other manual pages and links to other articles, same or different modules. For example, pages in Selling, Buying, and Stock have cross-related topics.
3. Keep relevance in mind when adding a link in this section.

## Format for Settings pages
A page would usually contain only three main sections, 1. Prerequisites 2. How to Create and 3. Features. But for settings pages like [Buying settings](https://erpnext.com/docs/user/manual/en/buying/buying-settings), this doesn't apply and the settings can be listed as:

1. Section group (H2)
1.1 subsection field/checkbox...,  (H3)
1.2...  (H3)
2. Section group
2.1 subsection/field etc. 
2.2...

# Instructions and examples

> Examples for reference: [Item](https://erpnext.com/docs/user/manual/en/stock/item), [Sales Order](https://erpnext.com/docs/user/manual/en/selling/sales-order)

## Test Company Test User?
**No!** 
Use realistic regular human names and data for your screenshots. 
The company name should be '**Unico Plastics Inc.**' abbreviation = 'UP'. Below is the logo.
![Unico_logo](https://user-images.githubusercontent.com/11595602/114659415-325ea380-9d11-11eb-9726-56564eee22e2.png)
Customer names can be as mentioned below.
* Watson Plastics Inc.
* Innovative Chemicals Inc.
* Massive Dynamic Inc.
* Unique Inc.

Supplier names can be as mentioned below.
* Kirkland and Watkins Inc.
* Awesome Plastics Inc.

## How to take screenshots?

Ensure your screenshots are clean and there's no cut off text.
For pointing out/highlighting buttons/areas use a sharp edged red box around it with the default red color on macOS #EE0000. Preferably use markdown style for linking images, it's just simpler: `![Image caption goes here](image path goes here)`.

For screenshots:
- **Ensure** that you show the navigation part (sidebar, breadcrumbs) on the top & left so that new users can quickly understand how to get to that screen/section. 
- Crop the screenshot so that there is only little padding width-wise, refer the [Item page](https://erpnext.com/docs/user/manual/en/item).
- Don't keep the borders too thick.

## Videos vs screenshots vs GIFs

- Avoid GIFs since we have no control to pause, rewind, jump ahead in the video
- Add videos for demonstrating complex processes
- Add clean screenshots for everything else

## Use American English everywhere

Use american english in docs (Customization, not Customisation)

## Module-wise structure

The hierarchy could be Modules -> Workspaces -> Doctypes/Features, Reports, Tools, Settings

**Inside every module:**

- Introduction
  - Could have flowcharts for the entire module (how different doctypes are connected)
- Setup
   - Pages for masters - Item, Item Group
   - 1 page for module implementation guidelines called "Getting Started"
- Features
   - could be sections with workspace names
   - On every page: include Related topics, include link to tools for speeding the process
- Settings
- Reports
- Tools