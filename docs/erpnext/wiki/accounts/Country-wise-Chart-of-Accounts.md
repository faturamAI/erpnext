The country-wise chart-of-accounts has been bootstrapped from a popular open source erp `odoo` (formerly openerp). In odoo, the charts were in xml or csv file format. But the major problem was, the charts were not visible in tree structure. We have converted them into json format, for better readability and to view them in tree structure.

### File Location

https://github.com/frappe/erpnext/tree/develop/erpnext/accounts/doctype/account/chart_of_accounts/

### JSON File Structure

	{
	    "country_code": "in",
	    "name": "Indian Chart of Accounts",
		"is_active": "Yes",
	    "tree": {
	        "Assets": {
	            "Current Assets": {
	                "Accounts Receivable": {
	                    "Debtors": {
	                        "account_type": "Receivable"
	                    }
	                },
	                "Inventories": {
		                "account_type": "Stock",
					},
	                "Cash In Hand": {
	                    "Cash Account": {
	                        "account_type": "Cash"
	                    }
	                },
					"Bank Accounts": {},
	            },
				"root_type": "Asset"
	        },
	        "Liabilities": {
	            "Current Liabilities": {
	                "Accounts Payable": {
	                    "Creditors": {
	                        "account_type": "Payable"
	                    }
	                }
				},
				"root_type": "Liability"
	        },
	        "Expense": {
	            "Cost of Goods Sold": {
	                "account_type": "Cost of Goods Sold"
	            }
				"root_type": "Expense"
	        },
	        "Income": {
				"root_type": "Income"
	        }
	    }
	}

After getting the tree, the major hurdle was to assign different properties (like root_type, account_type, is_group etc) for those accounts. The file contents are in the local language of that country. We have tried our best to read those using translate.google.com and assign multiple properties. We have finalized charts for some countries, but still there are many pending charts to finalize.

Hence, we decided to hand-over the task to the communities. Actually we realized that it is the perfect way of working for such cases. You have better knowledge for your country-specific charts and proficiency in your native language.

## Guidelines for contribution:

Please go to the above link and find the file for your country's chart of accounts. You can help us to assign different kind of properties for the accounts. 

1. If you are a developer, you can directly make the changes in json and send pull request.
2. If you are non-developer, you can mail us the changes at developers@erpnext.com in the format below:

	`"account_name": { "property_1": "value1", "property_2": "value2" }`

### Properties

+ **root_type:** Asset, Liability, Expense, Income, Equity
	
	It is applicable only for root account groups and is mandatory for all roots.
+ **account_type:**: Receivable, Payable, Cost of Goods Sold, Stock, Bank, Cash

	It is used to identify the type of a account. For example, the group under which warehouse account will be created, should be assigned as "Stock"
+ **is_group:** 1

	Used to identify account is a group or not. Assign 1 if there are child accounts on the node. For example, "Bank Accounts" in the above chart.

