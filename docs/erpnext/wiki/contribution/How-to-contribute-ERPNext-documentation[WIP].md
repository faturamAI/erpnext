## 1. What is the goal of this tutorial? 
Add the sentence “Prepare your Balance Sheet and Profit and Loss Statement” to ERPNext documentation.

Login to your ERPNext account, click on "Help" on top bar and click on "Documentation" under "Help".

Navigate to "Introduction" page.

In “Introduction” page you will see a list of things which ERPNext helps you do.

ERPNext helps you prepare your Balance Sheet and Profit and Loss Statement, lets add this to the list.

![](https://media.giphy.com/media/1TC4N6BuSNkCZ5h3g0/giphy.gif=250x250)

## 2. Any Pre-requisites?

a. Frappe development environment in your local machine.

   Please find below the links to guides on how to setup Frappe development environment.

   * [The Hitchhiker's Guide to Installing Frappé on Mac OS X](https://github.com/frappe/frappe/wiki/The-Hitchhiker%27s-Guide-to-Installing-Frapp%C3%A9-on-Mac-OS-X)
   * [The Hitchhiker's Guide to Installing Frappé on Linux OS](https://github.com/frappe/frappe/wiki/The-Hitchhiker%27s-Guide-to-Installing-Frapp%C3%A9-on-Linux-OS)

b. Should have basic understanding of Git.


## 3. Documentation is written in plain text, right?

Its not plain text, its not code, its text written in a particular style called [Markdown](https://www.markdownguide.org/).

## 4. Where does the documentation come from?

There is a folder called “docs” in erpnext app folder and all the documentation is stored in this folder.

For example the text on introduction page come from the file stored at

frappe-bench/apps/erpnext/erpnext/docs/user/manual/en/introduction/index.md

## 5. How to update documentation?
Goto frappe-bench/apps/erpnext folder and create a new branch using below command

```git checkout -b [Your branch name]```

Example:

```git checkout -b erpnext_documentation_introduction```

Open the index.md file under introduction folder with your favourite editor.

Insert “* Prepare your Balance Sheet and Profit and Loss Statement” after “ * Publish your website.” line.

Run below command to build the docs.

```bench --site [Your site name] build-docs erpnext --target erpnext```

Check the updated documentation by pointing your browser at

http://[Site name]:[Port name]/docs/user/manual/en/introduction

Ex:

```http://site11.local:8000/docs/user/manual/en/introduction```

Finally commit your changes.

```git commit -a -m "[Documentation only] Updated introduction"```

## 6. How to push changes to GitHub?

Fork ERPNext repo, add it as a remote and push your local changes by running below command...

Git Push --set-upstream [Remote Name] [Branch Name]

Ex:

```git push --set-upstream origin documentation_introduction```


## 7. How to update official ERPNext documentation?

Once you have pushed changes to your repo, open your GitHub repo in your browser and you will see an option to create a "Pull Request" to develop branch.

## 8. That is it?
Now your pull request will either be merged or you will get feedback on what needs to be changed.Your PR will be merged into develop branch first and then into master branch. Update your bench once your changes are merged into master and check documentation to see your contribution.

## 9. Am I a contributor now?
Yes you are! Celebrate!!

## 10. Who owns the documentation?
ERPNext Community! Specifically ERPNext Foundation owns all such assets.

Would you like to see more such tutorials? Send a pull request!
