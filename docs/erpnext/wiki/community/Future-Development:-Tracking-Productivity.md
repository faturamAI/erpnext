* How to track Productivity?

Tracking of productivity is vital for every manufacturing organisation and I know it is not going to be easy to get that thing done in EPRNext. At the time of writing there is no particular way to track productivity of an organisation in erpnext. This wiki looks at the possible solutions the rules that would be needed to be in place for tracking productivity in erpnext in future.

***

* Forms needed for Productivity Tracking.

Basically material moves between warehouses in erpnext through Stock Entries. Now in a process company the material in a warehouse undergoes a process in a particular machine. Now we don't have a way to track how much time an item took on the machine for a particular process. For this we could have a form which would take the following data:
* Machine on which the process was carried out (we have masters for this in erpnext)
* Operator who undertook the job (employee master)
* Item Code (there could be case when batch of items are processed like 2 or 3 items are processed)
* Quantity of item processed
* Start Time
* Stop Time
* Total Time taken for the process (Calculated field stop time - start time)

***

* Real Life Situation and Rules to Govern Such Entries.

Now we could have many items in a warehouse and the data entry person is generally not the machine operator since that person is not computer savvy at least in India. So we would have a case where a lot of entries are to be done in one go, so we could have a stock entry like page for this thing as well.

* We would have to ensure that if there are say 1000 pcs of Item A in for a Process in WH-1 then the data entry person cannot enter more than 1000 pcs into the productivity sheet.

* One machine cannot be involved in doing 2 jobs in 1 time. Like if a person enters the productivity sheet for MC-1 from 10AM to 1 PM for item A then that machine should be shown as occupied during this time (I hope people understand what I mean by this).

* We could have a Gantt Chart for Machines or Operator and maybe there we could have a birds eye view of the productivity or the machines' running time.

* We could also have a field for setup time involved in the machines' operation.