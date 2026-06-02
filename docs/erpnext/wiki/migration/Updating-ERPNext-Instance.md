### Updating for ERPNext Opensource project and commercial support

* Login as the erpnext user

```
cd /path/to/erpnext
./lib/wnf.py --update origin master --reload_gunicorn
```

### Updating for ERPNext commercial support with multitenancy 
####(with webnotes-agent)
* Login as the erpnext user

```
workon erpnext
cd ~/master/erpnext
wa deploy origin master
```
