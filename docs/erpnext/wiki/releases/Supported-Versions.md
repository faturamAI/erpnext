As a general principle, from Version 10 onwards, we plan to support each two major versions at a time, which roughly translates to 2.5-3 years of support lifecycle. The reason for this is that companies that have significant customization on top of ERPNext should be not be forced to move to new releases immediately.

Here is the support plan for major versions that are being supported now:

Version | EOL | Branch
--------|-----|--------
Version 14 | 31st January 2026 | `version-14`
Version 15 | End of 2027 (planned) | `version-15`
Version 16 | End of 2029 (planned) | `version-16`
Bleeding edge | N/A | `develop`


For contributors, this means that separate pull requests for bug fixes and security fixes must be sent for **each of the supported versions**.
Fixes to `version-14` will not automatically be merged into `version-15`, and so on. Please send a fix to the highest affected version (or `develop`) first. After it has been merged, create backports to the previous major releases.