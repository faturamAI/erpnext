Recently we have observed a need for splitting some modules from ERPNext monolith into separate app for various reasons. This article serves as guide for that transition.

We have created a short video tutorial regarding this. You can [watch it here](https://www.youtube.com/watch?v=LsvE2-8eUkI).

## Before Splitting

- Plan the splitting of module at least 1 month ahead of next major release. We should give ample time to users to plan any activities that are required for migration like installing the app, which is a manual process on central. 
- Update documentation about deprecation and app installation process.

## Splitting
- Create a new app using bench.
- Extract the module into a seperate repo using [git-filter-repo](https://github.com/newren/git-filter-repo).
- Use this new app and merge it with the previously extracted module.
- Migrate translations, if any, using the migrate-translations command, like: `bench --site kina migrate-translations erpnext lending`.
- Remove module specific code from ERPNext repo.
- If there is any module specific code that is spread across other modules, clean it up and move to appropriate place in the new repo.
- Setup hooks.py file to run it as an app in ERPNext.
- Create a new readme file with detailed description of the app.
- Add warning in Frappe/ERPNext that's visible to end user in current version. A bootstrap alert is good enough in most cases. [Example](https://github.com/frappe/erpnext/pull/26701/files#diff-6e5f2e554463c4ef6ca859ea4a1375a58c27f7762da855c53b756f0ceca63eefR22-R23).
- Add a warning for sysadmins by making an empty patch that just prints warning about module deprecation / removal. You can add more info about migration or make this conditional based on usage. [Example 1](https://github.com/frappe/frappe/blob/develop/frappe/patches/v14_0/drop_data_import_legacy.py), [Example 2](https://github.com/frappe/erpnext/blob/develop/erpnext/patches/v13_0/shopify_deprecation_warning.py).
- [IMPORTANT] Add a patch in new app for migrating existing data, wherever required.
- Each domain/module will have its own setup. In this, new records, custom fields, forms etc might have been created if required. Make sure to remove those records. This can be accomplished by writing a patch.
-  Drop all doctypes, releated patches from `develop` branch. Make sure to trace and remove any imports that are present in other files. 
- Ensure that PR conveys the breaking change.


## After Splitting
- Release notes for next major version should have "BREAKING CHANGES" section first with all the module removals.
- Publish it as an app in FC marketplace.
- Setup test data so that test suite can pass.
- Setup a CI system similar to Frappe/ERPNext so you can be sure that your app is in installable and usable state at all times. This will be slightly different from Frappe or ERPNext as your app will depend on both of them. [Reference CI for app that depends on ERPNext](https://github.com/frappe/ecommerce_integrations/tree/develop/.github)
- Test the app with & without the module and make sure migrations happen smoothly.