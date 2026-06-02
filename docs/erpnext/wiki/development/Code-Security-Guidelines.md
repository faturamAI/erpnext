## Prefer query builder over raw SQL

If you are writing simple SQL queries there is a high chance it can be achieved using the Frappe Query Builder.

Don't use `frappe.db.sql` for simple queries like this:

```py
result = frappe.db.sql('select name, title, description from tabToDo where owner = "john@example.com"')
```

Use `frappe.db.get_all` instead:

```py
result = frappe.db.get_all('ToDo', fields=['name', 'title', 'description'], filters={'owner': 'john@example.com'})
```

Read the full [API documentation](https://frappeframework.com/docs/user/en/api/database).

## Make your raw SQLs injection proof

If there are scenarios that you have to write raw SQL queries, make sure to account for SQL injections via user input that may be passed in a web request.

Don't use `.format` to substitute variables.

```py
result = frappe.db.sql('select first_name from tabUser where name="{}"'.format(user))
```

Pass variables to the `sql` method as a second parameter and they will be automatically sanitized and quoted.

```py
result = frappe.db.sql('select first_name from tabUser where name=%s', [user])
```

You can also use named variables and pass them as a dictionary:

```py
accounting_periods = frappe.db.sql("""
	SELECT
		ap.name as name
	FROM
		`tabAccounting Period` ap,
		`tabClosed Document` cd
	WHERE
		ap.name = cd.parent
		AND ap.company = %(company)s
		AND cd.closed = 1
		AND cd.document_type = %(voucher_type)s
		AND %(date)s between ap.start_date and ap.end_date
	""", {
		'date': posting_date,
		'company': company,
		'voucher_type': voucher_type
	})
```

If for some reason, you have to use `.format` to build your queries, make sure to sanitize your variables using `frappe.db.escape`.

```py
result = frappe.db.sql('select first_name from tabUser where name={}'.format(frappe.db.escape(user)))
```

## Don't allow creation of arbitrary documents via web request

Let's say you have created an API method `create_document`:

**api.py**
```py
@frappe.whitelist()
def create_document(values: dict):
  doc = frappe.get_doc(values).insert(ignore_permissions=True)
  return doc
```

This looks like a simple helper at first, but it allows a user to create **any** document on the site, since it bypasses the permissions check. Make sure to add additional checks if you really want arbitrary document creation.

You can use a combination of `frappe.only_for` method to restrict the method to System Managers and some manual checks. For e.g.,

```py
@frappe.whitelist()
def create_document(values: dict):
  frappe.only_for('System User')
  
  if values['doctype'] not in ('ToDo', 'Note', 'Task'):
    frappe.throw('Invalid Document Type')

  doc = frappe.get_doc(values).insert(ignore_permissions=True)
  return doc
```


## Prevent Code injection

- Avoid use of `eval` and `exec` functions in your code.
- If evaluating user-generated code is must then use `frappe.safe_eval` and `frappe.utils.safe_exec.safe_exec`.
- When using safe_eval and safe_exac, the security of the functions depends entirely on what you've supplied as whitelisted global functions and locals. Make sure whatever whitelisted functions you provide don't enable escaping the sandbox.
- Do not run arbitrary functions where you can't trust the input. 

Example:

```python
@frappe.whitelist()
def exec_method(method: str, *args, **kwargs):
    return frappe.get_attr(method)(*args, **kwargs)   # You just allowed user to call anything in python environment
```



## Unauthorized read/writes to file system 

If you're reading or writing to a file and user can somehow control the file path then they might be able to read everything on server. If full directory traversal is allowed then users can get your private keys or add their own public keys to access it using SSH. The possibilities are endless. To mitigate…

- Use "File" doctype API wherever possible to create files and read content. File doctype ensures that whatever you're reading and writing belongs to the site. 
- If it's not possible and you're accepting user input in any way make sure the path is:
    - not traversing back using /../../
    - In site's folder and not somewhere else.

Example:

```python
@frappe.whitelist()
def get_file(path: str):
    return open(path).read()  # This allows reading everything on server.
```



## Apply permissions by default

- Use `frappe.get_list` instead of `frappe.get_all` to ensure user can only read what they have permission to.
- `document.save`, `document.insert`, `document.submit` etc all check for permission. So you don't have to do anything special here. 
- `frappe.get_doc` doesn't check for permission by default, so if you're sending a document to user make sure you check permissions using `doc.check_permission("read")`


Example:

```diff
  @frappe.whitelist()
  def better_get_doc(doctype: str, name: str):
      doc = frappe.get_doc(doctype, name)  # This allows bypassing all permission and reading every document in system
+     doc.check_permission("read")  # this makes sure logged in user has correct permission to read the document
      return doc
```

## Check parameter types

Always check if the parameters passed to your whitelisted method have the type you expect. For example, if you accept a filter value for a specific company, like `"Example Corp"` a malicious user could instead pass a different filter object like `["is", "set"]`, thus changing the behavior of your code.

In v15+, type annotations will be checked automatically, you just need to provide them:

```diff
  @frappe.whitelist()
- def get_user(name):
+ def get_user(name: str):
      doc = frappe.get_doc("User", name)
      doc.check_permission("read")
      return doc
```

In v14 and below, you need to check types explicitly:

```diff
  @frappe.whitelist()
  def get_user(name):
+     if not isinstance(name, str):
+         raise ValueError("name should be a string")
      doc = frappe.get_doc("User", name)
      doc.check_permission("read")
      return doc
```
