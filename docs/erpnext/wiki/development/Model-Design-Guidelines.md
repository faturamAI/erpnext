### Numbering Series

For auto naming, use the format `[MOD]-[DOC]-.YYYY.-` where MOD is the module abbreviation and DOC is the DocType abbrevation.

For example: Lead in CRM module should be `CRM-LEAD-.YYYY.-`

### Avoid hard coding of Roles

No business logic should be based on hard coded roles. Either make it a configuration or set a property in User / Employee whether user has the permission to do the action.

### Make Contextual Settings

Sometimes to change the default behaviour of a transaction, a developer adds a global setting to allow it to behave in one way or another. These settings are hard to discover and hence must be avoided. Either these settings must be changeable at the transaction level with a Check type field, in the context.

Example: If you want to allow Orders and Invoice of different Currencies, don't make a global "Allow Invoice in a Separate Currency". The better design is to make a Check in the Sales Order to allow an invoice in a different currency. Even better, just ask the user to make a duplicate Sales Order and change the older one if the customer demands the invoice in another currency.