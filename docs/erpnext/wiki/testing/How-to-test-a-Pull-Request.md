#### Prerequisites 
 
 - Working frappe-bench with erpnext and frappe installed. Installed apps, Frappe and ERPNext must be on `develop` branch. (Generally feature pull requests are in develop branch)
 - refer bench [readme](https://github.com/frappe/bench)

### Steps :

change to app's directory and add git remotes/branches
follow these commands for erpnext:

```
~/frappe-bench$ cd apps/erpnext
~/frappe-bench/apps/erpnext$ git remote add mntechnique https://github.com/mntechnique/erpnext
~/frappe-bench/apps/erpnext$ git fetch mntechnique --unshallow 
```
drop option `--unshallow` if error - `fatal: --unshallow on a complete repository does not make sense`
Alternatively only the required branch can be fetched with
```
~/frappe-bench/apps/erpnext$ git fetch mntechnique consolidation:consolidation
```

set tracking branch if required
```
~/frappe-bench/apps/erpnext$ git branch -u mntechnique/consolidation 

Branch consolidation set up to track remote branch consolidation from mntechnique.
```

#### Pull and Migrate

if `bench update` doesn't work because of changed branches, pull and migrate can be used

checkout to the fetched branch from which pull request is made and pull changes
```
~/frappe-bench/apps/erpnext$ git checkout consolidation
~/frappe-bench/apps/erpnext$ git pull mntechnique consolidation
```
Migrate changes :
```
~/frappe-bench/apps/erpnext$ cd ../../
~/frappe-bench$ bench --site <testing_site> migrate
```

Same commands can be used to add remote to frappe git directory

Test and comment on pull requests / issue

Note : 
manually edit file `.git/config` to fetch all branches instead on just one.
```
~/frappe-bench/apps/erpnext$ subl .git/config
```
file should look like this, change the `fetch = +refs/heads/develop:...` to `fetch = +refs/heads/*:...`
```
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "upstream"]
        url = https://github.com/frappe/erpnext
        fetch = +refs/heads/develop:refs/remotes/upstream/develop
[branch "develop"]
        remote = mntechnique
        merge = refs/heads/develop
[remote "mntechnique"]
        url = https://github.com/mntechnique/erpnext
        fetch = +refs/heads/*:refs/remotes/mntechnique/*
[branch "consolidation"]
        remote = mntechnique
        merge = refs/heads/consolidation
```
remote `mntechnique` fetches all branches while `upstream` only `develop` in the above case