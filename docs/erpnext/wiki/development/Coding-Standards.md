
### User facing messages must be translated

All user-facing strings/text must be wrapped in the `__("")` function in javascript and `_("")` function in Python, so that it is shown as translated to the user.

### Break functions/methods more than 10 lines of code

Long functions are hard to read and debug, and 10 lines is usually a good point to break the function into smaller parts. Smaller functions are easy to read and review. You might even want to convert a series of functions into a class so you don't need to pass parameters through all of them.

As Steve Mcconnell and Bob Martin say (two pretty good references on coding best practices), a method should do one thing and only one thing. However many lines of code it takes to do that one thing is how many lines it should have. If that "one thing" can be broken into smaller things, each of those should have a method. Good clues your method is doing more than one thing:
- More than one level of indention in a method (indicates too many logic branches to only be doing one thing)
- "Paragraph Breaks" - whitespace between logical groups of code indicate the method is doing more than one thing

[Reference](https://stackoverflow.com/questions/611304/how-many-lines-of-code-should-a-function-procedure-method-have)

### Use simple indenting

The ERPNext and Frappe Project uses tabs (I know and we are sorry, but it's too much effort to change it now and we don't want to lose the history). The indentation must be consistent whether you are writing Javascript or Python. Multi-line strings or expressions must also be consistently indented, not hanging like a beehive at the end of the line. We just think the code looks a lot more stable that way.

You may want to write a SQL for fetching some data from the `tabItem` table. Your first preference should be to use the Frappe query builder (`frappe.qb`, `frappe.get_all`) or the Database APIs (`frappe.db.get_value`), but for the sake of this example we'll use raw SQL:

```py
frappe.db.sql("""select item_name, description, default_warehouse from tabItem 
                                    where disabled = 0""")              
```

The above query works, but we prefer:

```py
frappe.db.sql("""SELECT 
        item_name, description, default_warehouse 
    FROM
        tabItem 
    WHERE
        disabled = 0""")              
```

While writing queries using the query builder (`frappe.qb`), we like [Black](https://github.com/psf/black)'s formatting for the same.


```python
used_in = (frappe.qb
			.from_(doctype)
			.select(doctype.name)
			.where(doctype.autoname.like(Concat(prefix,".%")))
			.where(doctype.name != name)
			).run()
```

So, although the above query is valid and simply works, we prefer writing queries the following way:

```python
# brackets are used while assigning the return value, to result here for instance
result = (
	frappe.qb.from_(doctype)
	.select(doctype.name)
	.where(doctype.autoname.like(Concat(prefix, ".%")) & doctype.name != name)
).run()

# we prefer this styling when the return value doesn't need to be preserved
# specially in case of update/delete queries 
frappe.qb.from_(doctype).select(doctype.name).where(
	doctype.autoname.like(Concat(prefix, ".%")) & doctype.name != name
).run()
```



### Make your SQLs injection proof

If you are writing direct SQL query, don't use `.format` to replace strings. Example `frappe.db.sql('select age from tabUser where name='{}'.format(user))` is wrong. It should be `frappe.db.sql('select age from tabUser where name=%s', user)`

### Use simple structures 

Code must be easy to read, so don't try clubbing multiple conditions in one line and make it complex. If you have a line that has multiple AND or OR, break it up into multiple conditions.

### Function sequence

If you have multiple functions in a file, the **calling** function should be on the top and the **called** functions should be below. Check the example below:
  ```
  def fa():
    fb()
    fc()

  def fb():
    pass

  def fc():
    pass
  ```

### All business logic must be API friendly and must be implemented in Server Side (Python)

If you are implementing business logic like calculations or setting a value based on another, then it must be implemented in the Python controller along with the JS controller. The reason is that when documents are posted via REST API, then only the server side code is executed.

### Commit Messages

Commit messages must follow the conventional commit specifications (https://www.conventionalcommits.org/en/v1.0.0-beta.2/)

### Code Comments

While we believe that code should be written in a self-explanatory way, comments will go a long way in expressing "why" the code is written in a particular manner.

We don't expect heavily commented code, but some explanation of what a method does is required. [Read this post](http://antirez.com/news/124) on why code commenting is important.

### Avoid using Deprecated API

The API used in the pull request must be the latest recommended methods and usage of globals like `cur_frm` must be avoided.

Examples:
- `$c_obj()`
- `cur_frm`
- `get_query`
- `add_fetch`

### Tabs, not spaces

Please don't ask why, this has been the legacy. (Also, tabs use fewer bytes)