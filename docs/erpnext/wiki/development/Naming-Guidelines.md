Naming something is probably the most important decisions that you need to take as a user. Here are some guidelines will selecting names

> "To change this rock into a jewel, you must change its true name. And to do that, my son, even to so small a scrap of the world, is to change the world" - Wizard of Earthsea

### General Guidelines

1. Naming should be something that is used in common language. There are legacy ERP systems that have a specific naming style, we should constantly keep away from those styles, going with a more simple naming style. Shopify is a great example of how to name things. For example, in legacy ERP systems, a Purchase Receipt is called as "Goods Receipt Note".
2. Names should represent the essence of the concepts they represent and avoid accounting/management jargon. 
3. Names should be consistent with the rest of the system.
4. No abbreviations. Use complete names as far as possible in both object and variable naming.

### DocType naming

DocType names must be:

1. Title Case
2. Singular
3. Names with multiple words should be separated by a space. Example "Sales Invoice"
4. US English
5. Child table names should be parent table names + the relation, for example, "Sales Order Item"

### Field Naming

1. Labels must be sentence case (except links)
2. Link names must be same as the DocType they refer to (for example Link to "Employee" should be `employee`)
3. Table field names must be plural and just be the relation, for example, field name for "Sales Order Item" should be `items`
4. Field name must be the slugged version of the label ("First Name" must be `first_name`)
5. Avoid descriptions. Labels must be as clear as possible.
6. Use full names (not abbreviations)

### Variable Naming

1. Variables representing Document objects must be slugged versions of the DocType [example: `sales_order = frappe.get_doc('Sales Order', 'SO-0001')`]
1. Variables representing names, should be suffixed with `_name` [example: `sales_order_name`]
1. Child table in a loop can be `d` [example: `for d in sales_order.items`]
1. Avoid using numbered variables, like `i1, i2` etc. Use descriptive variables.


> Note: **Title Case** means to capitalize every word except articles (a, an, the), coordinating conjunctions (and, or, but), and (short) prepositions (in, on, for, up, etc.).