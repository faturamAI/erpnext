This page is intended to make it easier for users who maintain custom apps/forks to migrate their installations to `develop` branch aka the nightly version. This page assumes that you're on `v17.x.x-dev`.

---

### Ledger DocTypes marked as submittable

The following DocTypes have been marked as submittable:

- GL Entry
- Payment Ledger Entry
- Advance Payment Ledger Entry
- Stock Ledger Entry
- Account Closing Balance

These DocTypes were submitted in earlier versions by skipping validations. Now they have been [explicitly marked as submittable](https://github.com/frappe/erpnext/pull/52921) to maintain consistency with [stricter validation in Frappe Framework](https://github.com/frappe/frappe/pull/37009).