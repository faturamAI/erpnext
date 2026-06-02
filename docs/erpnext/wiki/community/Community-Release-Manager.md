### Introduction

The role of the community release manager is to ensure that regular, high quality releases happen in time and the install and update process of bench is does not break based for the community. The role is also to keep updating the contribution guidelines and help review and manage open pull requests from a guidelines point of view.

### Regular Release

Regular release should happen on a Tuesday. The release process should include:

1. Preparing release notes.
1. Manual / automated testing based on the [Standard Release Test Plan](https://github.com/frappe/erpnext/wiki/Standard-Release-Test-Plan) (SRTP).
1. Manually test new contributions / update.
1. Ensure all tests are passing.
1. Announcing the release with the release notes on the forum.
1. Maintain, automate and update the SRTP.
1. Manager release for `frappe`, `erpnext` and `bench` repos (if required)

### Contribution Review

1. Review open contributions for consistency with [Contribution Guidelines](https://github.com/frappe/erpnext/wiki/Contribution-Guidelines).
1. Tag, close contributions that are very far from the standard.

### Severe Bug Monitoring

1. Monitor severe bug reports on forum and GitHub.
1. Severe bugs include bugs that make the system unusable, or failure to install or upgrade.
1. Work with module maintainers to fix and make an urgent release if required.

### Monitoring of Security Reports and Notifications

1. Monitor security reports.
1. Work with module maintainers to fix security reports.
1. Maintain registry of security fixes.
1. Notify on the forum / website after quarantine period.