
#### Step 0: Configure Barracuda

*This step is only required if you ran the install script before 25th March, 2015*

Create 

* `/etc/mysql/conf.d/barracuda.cnf` in case of Debian/Ubuntu or 
* `/etc/my.cnf.d/barracuda.cnf` in case of CentOS / RedHat

with the contents,
```
[mysqld]
innodb-file-format=barracuda
innodb-file-per-table=1
innodb-large-prefix=1
character-set-client-handshake = FALSE
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci

[mysql]
default-character-set = utf8mb4
```

#### Step 1: Update bench-repo

As the frappe user, 
```
cd ~/bench-repo
git pull
```

#### Step 2: Upgrade
```
cd ~/frappe-bench
bench update --upgrade
```
This will take time.

#### Step 3: Restart services

If you've setup for production, run
```
service nginx restart
supervisorctl reload
```

as root.

Also, with version 5, the command line has changed, run
```
cd ~/frappe-bench
bench --help
```
to see the list of available commands