This page is intended to make it easier for users who maintain custom apps/forks to migrate their installations to `develop` branch aka the nightly version. This page assumes that you're on `v17.x.x-dev`

---

### `bleach` replaced by `nh3`

If your custom app relies on the `bleach` library, you'll have to add it to your app's dependencies, as this has been replaced by `nh3` in the develop branch. While the actual functionality was backported to v16, the library was left for those that may be reliant on it.


### Stricter `docstatus` validation for non-submittable doctypes

Saving a non-submittable doctype with `docstatus=1` now raises a `DocstatusTransitionError`. If you need to bypass this check, use the new flag:

```python
doc.flags.skip_docstatus_validation = True
doc.save()
```

Reference: [#37009](https://github.com/frappe/frappe/pull/37009)