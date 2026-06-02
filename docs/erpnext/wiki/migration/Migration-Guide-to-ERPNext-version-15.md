## Separating Modules from ERPNext to New Apps

Continuing last year's trend, some more modules have been moved out as separate apps:

- [TaxJar Integration](https://github.com/frappe/taxjar_integration)
- [Exotel Integration](https://github.com/frappe/exotel_integration)
- [Lending](https://github.com/frappe/lending)
- [French localization](https://github.com/scopen-coop/erpnext_france)
- [E-commerce](https://github.com/frappe/webshop)
- [Payments](https://github.com/frappe/payments)
- [KSA localization](https://github.com/8848digital/KSA)

The following modules were deprecated and later removed entirely from ERPNext:

- Social Media module (removed in [#37087](https://github.com/frappe/erpnext/pull/37087))
- WooCommerce integration (removed in [#37015](https://github.com/frappe/erpnext/pull/37015))

**How does this change affect you?**

If you are currently not using any of these modules, this change won’t affect you.

However, if you are using any of these modules, when you upgrade to version 15, you will have to **install the relevant app** on your bench.

From the user's point of view, it won’t make any difference, there will be **no loss of functionality**.

If you want to raise any new issues or pull requests, you will have to raise them on the respective repository instead of raising them on the ERPNext repository.


### - [Serial and Batch Bundle](https://docs.erpnext.com/docs/v14/user/manual/en/stock/serial-and-batch-bundle)

Before version 15 the serial number was a Small Text field in which users were adding multiple serial numbers. The Small Text field has a data integrity issue with the serial number. To solve this issue we have added a separate doctype Serial and Batch Bundle with Serial, Batch as link field. The serial and batch bundle user has to create and link to the child table in the sales, purchase, and stock transactions.


<img width="1342" alt="Screenshot 2023-06-02 at 2 36 24 PM" src="https://github.com/frappe/erpnext/assets/8780500/b7c6c2dd-a6c8-41bd-82f8-b8a81f935e4f">



**Print format changes**

With the new design Serial No / Batch No fields have been replaced with Serial and Batch Bundle link field. With the new Serial and Batch Bundle you won't get the Serial Nos / Batch Nos from the same form. You need to fetch the data from the `Serial and Batch Bundle` by passing the Serial and Batch Bundle id. To get the information about Serial / Batch Nos in the print format from the Serial and Batch Bundle either you can use the Jinja method `get_serial_or_batch_nos(bundle_id)` or get the data using frappe.get_all method. For reference kindly check the print format `Purchase Receipt Serial and Batch Bundle Print`

Standard Print Format for Serial and Batch Bundle will look like as below
<img width="747" alt="248766604-a605eced-9a23-4d28-ae7c-6439c298eae2" src="https://github.com/frappe/erpnext/assets/8780500/d8450e59-d978-44e1-81b0-69f6e0f48dc1">


If you have custom print format then you can use the below code
```
<table class="table table-bordered">
	<tbody>
		<tr>
			<th>Sr</th>
			<th>Item Name</th>
			<th>Serial / Batch No</th>
			<th class="text-right">Qty</th>
			<th class="text-right">Rate</th>
			<th class="text-right">Amount</th>
		</tr>
		{%- for row in doc.items -%}
		<tr>
			<td style="width: 3%;">{{ row.idx }}</td>
			<td style="width: 20%;">
				{{ row.item_name }}
				{% if row.item_code != row.item_name -%}
				<br>Item Code: {{ row.item_code}}
				{%- endif %}
			</td>
			<td style="width: 37%;">
				<div style="border: 0px;">{{ get_serial_or_batch_nos(row.serial_and_batch_bundle) }}</div>
			</td>
			<td style="width: 10%; text-align: right;">{{ row.qty }} {{ row.uom or row.stock_uom }}</td>
			<td style="width: 15%; text-align: right;">{{
				row.get_formatted("rate", doc) }}</td>
			<td style="width: 15%; text-align: right;">{{
				row.get_formatted("amount", doc) }}</td>
		</tr>
		{%- endfor -%}
	</tbody>
</table>
```

User can override the Template of the Serial and Batch Bundle print format using Custom APP

Add get_serial_or_batch_nos method in your custom app's hooks.py file (Check below image)

<img width="886" alt="Screenshot 2023-06-26 at 3 59 21 PM" src="https://github.com/frappe/erpnext/assets/8780500/6020eb20-2c4a-4742-ae4e-a4697b5d235c">

Write your custom Template code for the Serial and Batch Bundle print in the get_serial_or_batch_nos method and check
<img width="411" alt="Screenshot 2023-06-26 at 3 59 52 PM" src="https://github.com/frappe/erpnext/assets/8780500/14eec333-0431-41e5-bcbf-cec9e650846b">

## Hierarchy Chart moved to Frappe HR

Hierarchy charts were added as generic classes to visualize hierarchies for [Org Charts](https://github.com/frappe/erpnext/pull/26261). 
As it is not being used anywhere in ERPNext as of now, it has been removed in v15 and moved to the [hrms](https://github.com/frappe/hrms/pull/597) repo. `html2canvas`, a dependency added for exporting org charts to images is also removed from ERPNext. 

So if you are using these JS classes or the `html2canvas` library, you can install `hrms` or create a custom app for the functionality using these.

## Changed behaviour to add Portal Users for Suppliers & Customers

Before v15, the steps for adding a new **User** to the list of users who can access the **Supplier / Customer Portal** were as follows - 

* Create a **Website User** with the Supplier / Customer role.
* Create a **Contact** for the Supplier / Customer which acts like a dynamic link between the User and the Supplier / Customer.

Portal Users can now be added for a particular Supplier / Customer as follows -

* Navigate to the **Portal Users** tab for the Supplier / Customer.
* Add one or multiple Users to the table of users who can access the Portal.

> Note: The appropriate role is added automatically for the User once added to the Portal Users table.

## Cashflow Mapper

Cashflow mapper has been deprecated in ERPNext v15 and will no longer be available

## TDS Payable Monthly Report

The **TDS Payable Monthly** report has been renamed as **Tax Withholding Details**.

## Dunning

The **Dunning** DocType was previously linked to exactly one **Sales Invoice**. With v15, the link to **Sales Invoice** is removed. Instead, the **Dunning** contains a table of overdue payments, each linking to a **Sales Invoice**. Please adjust your scripts and print formats accordingly. Details: https://github.com/frappe/erpnext/pull/35689

## Reorder Levels

In v14, a **Material Request** was created, when the _Projected Quantity_ was **smaller** than the _Reorder Level_. In v15 a **Material Request** is created, when the _Projected Quantity_ is **smaller or equal** than the _Reorder Level_. Details: https://github.com/frappe/erpnext/pull/35831

## Employee User Permissions

Context: An **Employee** is linked to a **User** with _Create User Permission_ enabled, but the **User** is missing the 'Employee' role and associated **User Permissions**.

Change: In v14, adding the 'Employee' role to this **User** automatically created the missing **User Permissions**. In v15, this behavior is disabled; permissions are no longer auto-created in this scenario.