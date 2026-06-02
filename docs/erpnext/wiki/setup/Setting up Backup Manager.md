Setup of automated backups via Setup >> Backup Manager using Dropbox

### 1. Create an App in Dropbox

Firstly create your Dropbox account. Then create an app [here](https://www.dropbox.com/developers/apps).
After successful creation of app you will receive `app_key`, `app_secret` and `access_type`.

### 2. Update your site_config.json

Update the keys in `frappe-bench/sites/[sitename]/site_config.json`

```
{ 
 "db_name": "demo", 
 "db_password": "DZ1Idd55xJ9qvkHvUH", 
 "host_name": "http://demo.local:8000", 
 "dropbox_access_key": "ACCESSKEY", 
 "dropbox_secret_key": "SECRECTKEY" 
} 
```