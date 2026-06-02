Before you send a pull request, make sure to read the [Contribution Guide](https://github.com/frappe/erpnext/wiki/Contribution-Guidelines)

### Which Branch

As of February 2026, pull requests are accepted on the following branches:

Version  | Branch              | Allowed PRs
---------|---------------------|-----------
17       | `develop`           | bugfixes, features
16       | `version-16-hotfix` | backports, bugfixes`*`
15       | `version-15-hotfix` | backports, bugfixes`*`

`*` only for bugs that do not exist in higher versions.

Please don't send a Pull Request to all branches.

- Bugfixes should go into the highest affected version – when in doubt, choose `develop`. They will then be backported to supported lower versions.
- New features should always go into `develop` and _may_ be backported later.

When you want your Pull Request to be backported, please mention this in the description or add the label "backport version-XX-hotfix".

### Pull Request Titles and Commit Messages

We follow [Conventional commits](https://www.conventionalcommits.org/en/v1.0.0/) and a status check evaluates your PR title and the commit messages. If commits don't follow the conventional commits specification, the PR, if it follows the same will be squashed. 

Template for commit messages which can be extended for PR titles as well:
```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)] 
```
[Commit type reference](https://github.com/pvdlg/conventional-commit-types#commit-types)

### Maintainer edits

- Maintainers might need to modify your PR to suit the project. Please enable Maintainer Edits on all PRs. It's enabled by default, you can find it in the sidebar of PR. 
- Do not raise PR from organization forks as GitHub doesn't allow maintainer edits on organization forks. Use your personal fork instead. 

### Automated Changes are not allowed

Do NOT send pull requests based on changes generated using automated tools. This includes, but is not limited to:
- autofixes using linters, auto-fixes from tools like ruff, semgrep etc.
- Bulk typo fixes
- Using AI/LLMs/generative models for completely automated changesets that you have not seriously reviewed.  

Exemption: This rule is not enforced on existing maintainers. If you believe any automated change is valuable to project, create an issue and let maintainers do it.  

### Test Cases

Important to add test cases, even if its a very simple one that just calls the function.

#### Tests must pass

This is simple, you must make sure all automated tests are passing. If tests are failing due to your fixes, please fix your fixes. If tests are failing due to some other's changes, you must ping the project owner to make sure tests are passing.

#### Test Case Help

- [Unit testing](https://frappe.io/docs/user/en/guides/automated-testing/unit-testing)
- [UI testing](https://frappe.io/docs/user/en/ui-testing)

#### Why Add Tests?

Tests may seem like additional work, but they are very helpful for many reasons:

1. Forces you to think of all use cases
1. Makes the code API friendly
1. Makes it easy for code reviews
1. Ensures guarantee in case of future updates

### User Experience  (animated GIF)

If your change involves user experience, add a screenshot/narration/animated GIF. An animated GIF guarantees that you have tested your change and there are no unintended errors.

- [LiceCAP is a great tool to record short GIFs](https://www.cockos.com/licecap/)

### All business logic and validations must be on the server-side

If you are adding calculations or validations in your feature, they must also be on the server-side, for API users, and security.

If your contribution has a server-side change, tests must be added via on server-side

### Documentation

Pull requests must involve updating the necessary documentation. Please include the link to your documentation fix in the body of your pull request.

- [Documentation Guidelines](https://github.com/frappe/erpnext/wiki/Updating-Documentation)

### Explanation

Include a detailed explanation for your changes, with before and after screenshots. If there is a design change, explain the use case and why this suggested change is better. If you are including a new library or replacing one, please give sufficient reference to why the suggested library is better.

### Migration Patches

If your design involves schema change then you must include patches that update the data as per your new schema. The patch must be added to the correct subdirectory of `frappe/patches` based on the version which it affects in addition to `patches.txt`.

- [How to write migration patches](https://frappe.io/docs/user/en/guides/deployment/migrations)

### Parallel Pull Requests for Bug / Security Fixes


We use mergify service to automatically port changes to current stable branches from develop branch.
 
Please mention in your pull request description which versions your PR should be ported to. 

You can alternatively also ask mergify to do it by commenting `@merifyio backport version-x-hotfix` (replace branch name)

### Linting

This repository uses [pre-commit](https://pre-commit.com/) to ensure that basic code style and correctness requirements are met before merging any PRs. While the suite of linting/formatting tools might keep evolving you just need to install `pre-commit` to get started. It will install and configure the required tools.  

- `$ cd apps/frappe` or `$ cd apps/erpnext`
- `$ python -m pip install pre-commit`
- `$ pre-commit install` (from ERPNext repository folder)

This will configure a git pre-commit hook which will ensure that your changes pass bare-minimum style/correctness requirements for accepting the changes. 

![pre-commit](https://user-images.githubusercontent.com/9079960/131657035-f43d6324-131a-4337-9cb0-587edba33e73.png)

You can skip running pre-commit by passing `-n` flag like `git commit -n`

Current checks:
- ruff (linting, formatting, import sorting for python)
- Whitespace trimming (style)
- prettier - formatting JS files
- eslint - linter for JS files