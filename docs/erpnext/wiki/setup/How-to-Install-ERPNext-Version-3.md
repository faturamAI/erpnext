### Version 4: Use Frappe Bench

https://github.com/frappe/frappe-bench

---

### Version 3

0. Make sure that you have Python 2.7+
```
$ python -c "import platform; print platform.python_version()"
2.7.3
```
or
```
$ which python2.7
/usr/bin/python2.7
```
If your python version is less than 2.7, then follow,
	* For CentOS, you can refer to http://toomuchdata.com/2012/06/25/how-to-install-python-2-7-3-on-centos-6-2/
	* For Ubuntu, refer to http://askubuntu.com/questions/101591/how-do-i-install-python-2-7-2-on-ubuntu/101595#101595

1. Make sure the 'passwd' command exists. Install passwd if necessary (e.g. on CentOS, run `yum install passwd`)
1. Switch to root user using `sudo su`
1. `wget https://raw.github.com/webnotes/erpnext/master/install_erpnext.py`
1. `python2.7 install_erpnext.py --create_user`

 This will create a user 'erpnext' and install erpnext in its home directory.
To start a development server, login as erpnext with password erpnext (or `su erpnext` from your root shell)
```
cd /home/erpnext/erpnext
./lib/wnf.py --serve
```

> If you are installing on your server for deployment, remember to change Administrator's password!
> You can set the erpnext username and password by passing it to the install script,
`python2.7 install_erpnext.py --create_user --username erpnext_username --password secretpassword`

> If you get stuck, post your questions at [ERPNext Developer Forum](https://groups.google.com/forum/#!forum/erpnext-developer-forum)

> [Troubleshooting SELinux](http://www.crypt.gen.nz/selinux/disable_selinux.html)

--

> [Server Setup Tips](http://plusbryan.com/my-first-5-minutes-on-a-server-or-essential-security-for-linux-servers)

> [MySQL configuration file - my.cnf](MySQL-configuration-file)

> [Some Useful Aliases](Some-Useful-Aliases)

---
### Upgrade / run latest patches

[Updating-ERPNext-Instance](https://github.com/webnotes/erpnext/wiki/Updating-ERPNext-Instance)
> [Restoring from ERPNext backup](Restoring-From-ERPNext-Backup)