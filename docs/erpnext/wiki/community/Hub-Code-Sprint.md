- [ ] Data Migration Run
  - [x] Fields: Data Migration Connector, Data Migration Plan, Status (Pending, Started, Success, Fail)
  - [x] `push_since_last_run` 
  - [x] `push_deleted_items`
  - [x] validate there are no failed runs before this one
  - [x] ability to skip failed items (check)
  - [x] save `failed_items_log` in Data Migration Run
  - [x] count records from all mappings before starting run, for better progress
  - [x] push items with no `migration_id`
  - [x] rename `migration_id` based on plan name `hub_sync_id` (since each document can be part of multiple syncs)
  - [ ] mapping for child tables
- [ ] Hub Settings
  - [x] Create Data Migration Connector (on registration)
- [ ] Progress Indicators and Status
- [ ] Data Migration Plan
  - [ ] Add Frequency

---

- [ ] Email verification (delayed) - maybe add a field to company (verified) and show in hub as (unverified)


Prateeksha, Faris
- [ ] Unselect country
- [x] show all products (including mine)
- [ ] success message on registering to hub
- [x] standard empty state for page
- [x] modal for enabling hub
- [x] Button to move from "Hub Settings" to "Hub"
- [ ] Ability to set category in Hub in Hub page

Achilles, Ameya
- [ ] "Go to Hub" button in Hub Settings
- [ ] Add "Publish to Hub" in Item Group
- [ ] Docs

Rushabh, Nabin
- [ ] Polling for hub
- [ ] Terms
- [ ] About
- [ ] Report Abuse
- [ ] Ask user to select item code / supplier at time of placing order. First try matching by name, if not exists, ask user to create (check) or select.

Manas, Vishal
- [ ] Hub website: show items for Guests
- [ ] Ask for login when they take any action
- [ ] Navigation