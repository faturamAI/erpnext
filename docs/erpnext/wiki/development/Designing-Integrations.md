### Avoid 2-way sync

Two way syncing is not a good idea unless its absolutely necessary. If you are integrating with a 3rd party marketplace or e-commerce, try pulling in orders and customers and pushing fulfillment. If you try 2-way sync for items, it will not scale well and also conflicts get hard to manage.

### Use Generic Names in Standard Workflow

In the standard workflow, use generic names first and then add custom fields to specify which is the exact provider.

For example if you are integrating with Fedex, in the Delivery Note, add "Shipping Provider" as the link and within Shipping Provider, add custom fields for Fedex (if needed). So all integration code is maintained separately and does not seep into the core workflow.