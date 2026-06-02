The following provides a database of community developed custom scripts for implementing unique features through the ERPNext custom script tool. In certain cases, server-side scripts have also been written to support the client-side scripts.

### Attachment transfer
This script takes attachments identified in specific custom fields of an Item document and copies them into another document as general attachments. This is used in practice to attach critical design documents to Request for Quotations and Purchase Orders that get sent automatically through e-mail.

**Custom Script**

    frappe.ui.form.on("Request for Quotation",{
	refresh: function(frm) {
        frm.add_custom_button(__("Load Attachments"), function(foo) {

		frappe.call({
			method:"my_app.my_app.controller.attach_all_docs",
			args: {
				document: cur_frm.doc,
				
			}, 
			callback: function(r) { 
				frm.reload_doc();

			}
		});
        });
        }
    });

**Server-Side Script**

    @frappe.whitelist()
    def attach_all_docs(document, method=None):
        """This function attaches drawings to the purchase order based on the items being ordered"""
        document = json.loads(document)
	
        current_attachments = []
        for file_url in frappe.db.sql("""select file_url from `tabFile` where attached_to_doctype = %(doctype)s and     attached_to_name = %(docname)s""", {'doctype': document["doctype"], 'docname': document["name"]}, as_dict=True ):
            current_attachments.append(file_url.file_url)
            count = 0
            for item_doc in document["items"]:
                #frappe.msgprint(item_doc)
                # Check to see if the quantity is = 1
                item = frappe.get_doc("Item",item_doc["item_code"])
		
                attachments = []
                # Get the path for the attachments
                if item.drawing_attachment:
                    attachments.append(item.drawing_attachment)
                if item.stp_attachment:
                    attachments.append(item.stp_attachment)
                if item.dxf_attachment:
                    attachments.append(item.dxf_attachment)
                if item.x_t_attachment:
                    attachments.append(item.x_t_attachment)
			
                for attach in attachments:
                    # Check to see if this file is attached to the one we are looking for
                    if not attach in current_attachments:
                        count = count + 1
                        save_url(attach, document["doctype"], document["name"], "Home/Attachments")
        frappe.msgprint("Attached {0} files".format(count))

***
### Calculating Values in Child Tables

to calculate the values of child tables, you can use the following functions:
```
frappe.ui.form.on("[CHILD TABLE DOCTYPE]", {
	[CHILDTABLEMULTIPLE1]: function(frm, cdt, cdn) {
		var d = locals[cdt][cdn];
		var total = 0;
		frappe.model.set_value(d.doctype, d.name, "[CHILDTABLEPRODUCT]", d.[CHILDTABLEMULTIPLE1] * d.[CHILDTABLEMULTIPLE2]);
        frm.doc.[CHILDTABLEFIELDINPARENT].forEach(function(d) { total += d.[CHILDTABLEPRODUCT]; });
        frm.set_value('[PARENTDOCTYPETOTALFIELD]', total);
	}
});
frappe.ui.form.on("[CHILD TABLE DOCTYPE]", {
	[CHILDTABLEMULTIPLE2]: function(frm, cdt, cdn) {
		var d = locals[cdt][cdn];
		var total = 0;
		frappe.model.set_value(d.doctype, d.name, "[CHILDTABLEPRODUCT]", d.[CHILDTABLEMULTIPLE1] * d.[CHILDTABLEMULTIPLE2]);
        frm.doc.[CHILDTABLEFIELDINPARENT].forEach(function(d) { total += d.[CHILDTABLEPRODUCT]; });
        frm.set_value('[PARENTDOCTYPETOTALFIELD]', total);
	}
});
```
***
### Fetch child table

The following fetches all entries in a child table from another document.

```
frappe.ui.form.on("DocTypeB", "Trigger", function(frm) {
    frappe.model.with_doc("DocTypeA", frm.doc.trigger, function() {
        var tabletransfer= frappe.model.get_doc("DocTypeA", frm.doc.Trigger)
        $.each(tabletransfer.ChildTableA, function(index, row){
            d = frm.add_child("ChildTableB");
            d.field1 = row.fielda;
            d.field2 = row.fieldb;
            cur_frm.refresh_field("ChildTableB");
        });
    })
});
```
***
### Fetch fields from another DocType into a child table
This script takes data from another DocType source field and copies it onto a target field within the Child table in the current form or document (when you are editing it or on refresh). This is useful for pulling custom fields in Item DocType unto Sales Invoice Item, Purchase Receipt Item, etc.

**Important**: Make sure that the field Types as defined in the Customize Form or Custom Field, match for both the Source and the Target DocTypes!

```
frappe.ui.form.on("[PARENT_DOCTYPE_TARGET]", "refresh", function(frm) {	
	frappe.ui.form.on("[CHILD_TABLE_TARGET_DOCTYPE]", {
			"[CHILD_TABLE_LINK FIELD]": function(frm) {
			frm.add_fetch("[CHILD_TABLE_LINK FIELD]", "[SOURCE_CUSTOM_FIELD2]", "[TARGET_CUSTOM_FIELD2]");
		}
	});

});
```
Note:  If you wish to fetch data for a field within the parent doctype, then, add the frm.add_fetch line immediately below the line
```frappe.ui.form.on("[PARENT_DOCTYPE_TARGET]", "refresh", function(frm) {	```

***
### Fetch values from a child table to another child table

The following code will help you set a Select field in a child table dynamically on the basis of values in another child table.

* Basically, the use case could be: There's a DocType A, having a field Supplier. There's a child table C, in DocType A, which has a custom field `supplier_number` and a link field `item_code` which connects it with another DocType B which could be Item.

* Now, DocType B has a child table D, with two fields - `supplier` and `supplier_number`, and there are multiple values for `supplier_number` having the same Supplier. Now, you want to fetch Supplier Numbers in DocType A's child table on the basis of the Supplier selected on the trigger of the link field.

* First of all, create a Custom Field in DocType A's child table (C) with its fieldtype as Select. Then, add the following Custom Script for DocType A.
```
frappe.ui.form.on("[CHILD_TABLE_TARGET_DOCTYPE]", {
	[CHILD_TABLE_LINK_FIELD]: function(frm, cdt, cdn) {
		var row = locals[cdt][cdn];
		if (row.[CHILD_TABLE_LINK_FIELD]) {
			frappe.model.with_doc("[SOURCE_DOCTYPE]", row.[CHILD_TABLE_LINK_FIELD], function() {
				var doc = frappe.model.get_doc("[SOURCE_DOCTYPE]", row.[CHILD_TABLE_LINK FIELD]);
				$.each(doc.[SOURCE_DOCTYPE_CHILD_TABLE] || [], function(i, r) {
					if(r.[SOURCE_CHILD_TABLE_FIELD] == frm.doc.[TARGET_PARENT_DOCTYPE_FIELD]) {
						var df = frappe.meta.get_docfield("CHILD_TABLE_TARGET_DOCTYPE","[TARGET_CHILD_TABLE_CUSTOM_FIELD]", frm.doc.name);
						df.options += ["\n" + r.[TARGET_CHILD_TABLE_CUSTOM_FIELD]];
					}
				})
			});
			frm.refresh_field("[TARGET_DOCTYPE_CHILD_TABLE]")
		}
	}
});
```

***
### Push Changes to a document from another document.

The following code will push changes to a document.

	//Replace "DocType" with the source DocType
	frappe.ui.form.on("DocType", {
		//The trigger can be changed, but refresh must be used to use a button
		refresh: function(frm) {
			//The following line creates a button.
			frm.add_custom_button(__("Update"),
				//The function below is triggered when the button is pressed.
				function() {
					frappe.call({
						"method": "frappe.client.set_value",
						"args": {
							//replace "Target DocType" with the actual target doctype
							"doctype": "Target DocType",
							//replace target_doctype_link with a link to the document to be changed
							"name": frm.doc.target_doctype_link,
							"fieldname": {
								//You can update as many fields as you want.  
								"target_field_1": frm.doc.source_field_1,
								"target_field_2": frm.doc.source_field_2,
								"target_field_3": frm.doc.source_field_3,
								"target_field_4": frm.doc.source_field_4,
								"target_field_5": frm.doc.source_field_5  //Make sure that you do not put a comma over the last value
							},
						}
					});
			});
		}
	});

If you have any problems, please comment on the discussion thread on the ERPNext forum 
https://discuss.erpnext.com/t/tutorial-push-changes-to-another-document/18317
***
### Host custom script files on DropBox
If you want to load a .js file from DropBox as a custom script, you can use the following code in your custom script file:

```
var script = document.createElement("script");
script.type = "text/javascript";
script.src = "https://www.dropbox.com/s/yeoasv2glsve0za/tut.js?raw=1";
script.onload = function(){
console.log("Agent_Calculator Loaded");
};
 
document.head.appendChild(script);
```
The line `script.src = "https://www.dropbox.com/s/yeoasv2glsve0za/tut.js?raw=1";` needs to be updated with your own file hosted on DropBox.

When you get a share link in DropBox, in this case the file shown above, it will look like:
`https://www.dropbox.com/s/yeoasv2glsve0za/tut.js?dl=0`

You must replace `dl=0` with `raw=1`.  Once you have done that, you can paste it into the script as shown above.  

The file in the example is valid and can be used for testing.

If you have any problems, please comment on the discussion thread on the ERPNext forum
https://discuss.erpnext.com/t/tutorial-host-your-custom-scripts-on-dropbox/18296

***
### Manual Dropbox Backup
#### NOTE: THIS NO LONGER WORKS ON ERPNEXT 7.1 AND BEYOND.
Add this to Setup > Custom Script > New  
Doctype : Dropbox Backup  
Script :
```
frappe.ui.form.on("Dropbox Backup", "refresh", function(frm){
	if(frm.doc.send_backups_to_dropbox){
		frm.add_custom_button(__("Take Backup"), function() {
			frappe.call({
				method: "frappe.integrations.doctype.dropbox_backup.dropbox_backup.take_backups_dropbox",
				freeze: true,
				freeze_message: __("Taking backup"),
				callback: function(r){
					if(!r.exc) {
						frappe.msgprint(__("Backup taken successfully"));
					} else {
						frappe.msgprint(__("Error while taking backup. <br /> " + r.exc));
					}
				}
			});
		})	
	}
});
```