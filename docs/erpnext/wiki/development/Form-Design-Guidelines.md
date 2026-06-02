Please keep these rules in mind while designing forms

### 1. Proximity

Fields related to each other should be next to each other. If the visibility of a field is dependent on another field, it must ideally be below the field.

### 2. Important and Mandatory Fields on the Top and Left

Important and mandatory fields should be on the top and left. This is the area that gets maximum attention of the user. If the mandatory fields are in the bottom, users may not scroll all the way down and then will get an error, making them go back and fix something.

### 3. Section Must Have Less Than Six Fields

If your section is having more than 6 fields, try and group them into a separate section. Sections promote hierarchy, that make the form look organized and make it easy for users to skim through the data they are looking for.

### 4. Set Default Values

Keep the number of mandatory fields you want the user to enter at an absolute minimum. Please use defaults, either global, or in context of the workflow.

### 5. Dashboard of Related Items

If your document is related to other items, the Form Dashboard must show a list of all related documents in a grouped manner. This will enable *contextual discovery and navigation*, and the user will be able get a quick understanding of what is the relation of this document related to the rest of the system.

### 6. Every Section Must Have a Heading

If your section does not have an heading, it will be considered an extension of the previous section. Section heads help the form look organized.

### 7. Avoid Using Buttons Inside the Form

Avoid the pattern where you will "fetch" data based on a button as much as possible. This must be done automatically on selection. If you need buttons, then put them on the toolbar.

### 8. Transactions must be Auto Numbered

Only documents that represent things that have names in the real world should have user created names, for the rest, the document name must be an auto-number. For example an Invoice

### 9. All documents must have a dashboard or contextual links

No piece of information lives by itself, it is always connected to some other piece of information. Having contextual navigation makes it easier for the user to comprehend how this document lives in context to other documents. A dashboard can be added by setting "Document Links" in the DocType.

### 10. Avoid adding field descriptions unless necessary

Make field and section labels and titles as self explanatory as possible. Descriptions are additional UI that clutter the form and should be used very rarely to give additional information about the field.

### 11. Positioning of "Enabled" or "Disable"

If the form has an "Enabled" or "Disabled" field, it must be in the last field in the first column of the first section. When the form is disabled, all fields other than the enable/disable field should be read-only.

### 12. Logs related to a transaction / sync / integration must be linked in the "Settings"

If there are any logs related to background activities related to an integration or transaction, they must linked from the parent transaction or the configuration object. (Example: General Ledger Entries for an invoices are linked form the Invoice, or Email Queue linked from Email Account).