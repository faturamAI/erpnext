#### Steps to setup development environment and contributing changes to the agri-farm-erpnext branch.

## Fork erpnext to your user or organization repository

1.	fork erpnext 

## On your development machine (virtualbox linux, for example)

2.	```git config -e```
3.	This opens the .git/config file 
4.	Make sure your remote upstream fetch configs look something like this (by default get-app fetches only the develop branch)
5.	
```
	[remote "upstream"]
	      url = https://github.com/frappe/erpnext
	      fetch = +refs/heads/develop:refs/remotes/upstream/develop
	      fetch = +refs/heads/agri-farm-erpnext:refs/remotes/upstream/agri-farm-erpnext
	[remote "origin"]
  	      url =	https://github.com/<your github username>/erpnext 
  	      fetch = +refs/heads/agri-farm-erpnext:refs/remotes/origin/agri-farm-erpnext
```
		
6.	Perform a ```git fetch --all``` with your current working directory as ```frappe-bench/apps/erpnext```
7.	Now execute this to checkout 2 new branches agri-farm-erpnext and origin_agri
```
git checkout -b agri-farm-erpnext --track upstream/agri-farm-erpnext
git checkout -b origin_agri --track origin/agri-farm-erpnext
```
8.	Do a ```git branch -vv```
9.	Your current branch should be ```origin_agri```

## Make a pull Request !!

10.	Make your changes on this local branch + ```git add .``` + ```git commit -m "<your commit message>"``` + ```git push origin HEAD:agri-farm-erpnext```
11.	You'll have pushed your changes to ```agri-farm-erpnext``` branch on your forked repository.
12.	Now visit ```https://github.com/<your github username>/erpnext/tree/agri-farm-erpnext```
13. Click on **New Pull Request**
14. Now click on **Create Pull Request**!
