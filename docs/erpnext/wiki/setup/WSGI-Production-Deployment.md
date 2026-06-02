_Note: This post applies to an older version of ERPNext_

## Version 4

Use [Frappe Bench](https://github.com/frappe/frappe-bench)

## Version 3

For production use, we recommend a production ready wsgi server (eg gunicorn)
and reverse proxied via nginx. Also, in production you should use nginx to serve
static files.

###WSGI Server
	
* Install gunicorn, `pip install gunicorn`

###Supervisor

* Everytime the code is updated, the wsgi server has to restart to load the
  changes. As the wsgi server is a long running process, you should use
  a process manager like supervisord. 

* Install: 
	`sudo apt-get install supervisor`
	or 
	`sudo yum install supervisor`

* Configuration: Add a file gunicorn.conf to /etc/supervisor/conf.d/
	```
	[program:gunicorn]
	command=gunicorn -b 127.0.0.1:8000 -w 2 -t 120 lib.webnotes.app:application
	directory=/path/to/erpnext
	user=erpnext
	process_name=%(program_name)s
	autostart=True
	autorestart=True
	redirect_stderr=True
	```

* `sudo supervisorctl reload`

###NGINX

* Install

	* Installing nginx on CentOS: http://www.rackspace.com/knowledge_center/article/centos-installing-nginx-via-yum
	  Installing nginx on Ubuntu: https://www.digitalocean.com/community/articles/how-to-install-the-latest-version-of-nginx-on-ubuntu-12-10

* configure, /etc/nginx/nginx.conf

```
worker_processes 1;

user www-data www-data;
pid /var/run/nginx.pid;
error_log /tmp/nginx.error.log;

events {
	worker_connections 1024;
	accept_mutex off;
}


http {
	include mime.types;

	default_type application/octet-stream;
	access_log /tmp/nginx.access.log combined;
	sendfile on;
	types_hash_max_size 2048;

	upstream erpnext {
		server 127.0.0.1:8000 fail_timeout=0;
	}

	server {
		listen 80 default;
		client_max_body_size 4G;
		server_name localhost;
		keepalive_timeout 5;
		sendfile on;
		root /path/to/erpnext;

		location /private/ {
			internal;
			try_files /$uri =424;
		}
		
		location / {
			try_files /public/$uri @magic;
		}
		
		location @magic {
			proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
			proxy_set_header X-Use-X-Accel-Redirect True;
			proxy_set_header Host $http_host;
			proxy_read_timeout 120;
			proxy_redirect off;
			proxy_pass  http://erpnext;
		}
	}
}
 ```

###Updating

```
cd /path/to/erpnext
./lib/wnf.py --pull origin master 
./lib/wnf.py --latest
./lib/wnf.py --build
sudo supervisorctl restart gunicorn
```

Optionally, you can also use Apache to reverse proxy to gunicorn/uwsgi. However,
it is not possible to serve static files directly via Apache.

https://help.ubuntu.com/community/ApacheReverseProxy
http://stackoverflow.com/questions/1997001/setting-up-a-basic-web-proxy-in-apache#answer-1997047

