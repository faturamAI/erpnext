* Backup your database and files using: Tools > Download Backup
* Upgrade to Python 2.7+

	* For CentOS, you can refer to http://toomuchdata.com/2012/06/25/how-to-install-python-2-7-3-on-centos-6-2/
	* For Ubuntu, refer to http://askubuntu.com/questions/101591/how-do-i-install-python-2-7-2-on-ubuntu/101595#101595

	Make sure you use **altinstall** so as not to break your existing operating system tools.

* **Don't** use lib/wnf.py for updating. Use git commands to pull updates in app and lib folders.

	```
	cd app && git pull origin master && cd ..
	cd lib && git pull origin master && cd ..
	sudo pip install -r lib/requirements.txt
	./lib/wnf.py --latest
	./lib/wnf.py --build
	```

* To update in future, you may use wnf.py pull,
	```
	cd app && git pull origin master && cd ..
	cd lib && git pull origin master && cd ..
	./lib/wnf.py --latest
	./lib/wnf.py --build
	```


Development Sever
-----------------

* `./lib/wnf.py --serve` 

The serve command starts a development server on port 8000. You do not have to
run apache server for development.
