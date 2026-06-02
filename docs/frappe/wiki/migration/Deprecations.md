# Frappe Deprecation Warnings

Frappe uses a system of deprecation warnings to alert developers about features that are being phased out or have already been removed. These warnings are categorized based on the version in which the deprecation takes effect.

## Graduation

_Graduation_ refers to a deprecation being converted to an _Error_ during an entire major version before being removed entirely from the next major version.

- Conversion to error: from release of the graduation version
- Removed entirely: from release of the next version after the graduation version

## Classes of Deprecation Warnings

Deprecations warnings inherit from the following base classes for ease of managing warning notifications with `PYTHONWARNINGS`.

### FrappeDeprecationError

_Feature is being graduated during this major version._


> [!TIP]
> To temporarily downgrade these errors to warnings in an emergency:
> ```console
> export PYTHONWARNINGS="always::frappe.deprecation_dumpster.FrappeDeprecationError"
> ```

### FrappeDeprecationWarning

_Feature will be graduated during the next major version._

> [!IMPORTANT]
> You should not ignore these warnings and follow the instructions timely.


### PendingFrappeDeprecationWarning

_Feature may be potentially graduated during a major version beyond the next major version._ 

> [!NOTE]
> These warnings are ignored by default.

It is possible that such a deprecation decision may be reverted, meaning that the old and the new way will be considered stable.

> [!TIP]
> The new variant is considered stable and preferred.
> You are encouraged to migrate, regardless of whether the formal deprecation of the old variant may be dropped.

### VXXFrappeDeprecationWarning

As long as the corresponding base class is not suppressed, you'll see the specific version in which a feature is slated for graduation in the logs:

```python
V15FrappeDeprecationWarning: frappe.utils.make_esc is deprecated. ...
V16FrappeDeprecationWarning: frappe.utils.make_esc is deprecated. ...
V17FrappeDeprecationWarning: frappe.utils.make_esc is deprecated. ...
V18FrappeDeprecationWarning: frappe.utils.make_esc is deprecated. ...
...
```

## Configuration

To configure how to show warnings, you can use the `PYTHONWARNINGS` env variable in your development, CI and production environments according to the respective needs.

**Examples**

- Ignore all deprecation warnings:
  ```bash
  export PYTHONWARNINGS="ignore::frappe.deprecation_dumpster.FrappeDeprecationWarning"
  ```

- Emergency downgrade FrappeDeprecationErrors from default `error` to `always`:
  ```bash
  export PYTHONWARNINGS="always::frappe.deprecation_dumpster.FrappeDeprecationError"
  ```

- Upgrade PendingFrappeDeprecationWarnings from default `ignore` to `always`:
  ```bash
  export PYTHONWARNINGS="always:frappe.deprecation_dumpster.PendingFrappeDeprecationWarning"
  ```

- Specifically show deprecations which will graduate in v18:
  ```bash
  export PYTHONWARNINGS="always::frappe.deprecation_dumpster.V18FrappeDeprecationWarning"
  ```


## References

- https://github.com/frappe/frappe/pull/28453
- https://docs.python.org/3/library/warnings.html#describing-warning-filters