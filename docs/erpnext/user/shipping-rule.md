<div class="py-6 mb-6 border-b border-[var(--outline-gray-1)]">

<div class="flex items-center justify-between gap-4">

# Shipping Rule

<img src="data:image/svg+xml;base64,PHN2ZyBjbGFzcz0idy00IGgtNCB3LTQgaC00IiBmaWxsPSJub25lIiBzdHJva2U9ImN1cnJlbnRDb2xvciIgdmlld2JveD0iMCAwIDI0IDI0Ij4KICAgICAgPHBhdGggc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBzdHJva2Utd2lkdGg9IjIiIGQ9Ik04IDE2SDZhMiAyIDAgMDEtMi0yVjZhMiAyIDAgMDEyLTJoOGEyIDIgMCAwMTIgMnYybS02IDEyaDhhMiAyIDAgMDAyLTJ2LThhMiAyIDAgMDAtMi0yaC04YTIgMiAwIDAwLTIgMnY4YTIgMiAwIDAwMiAyeiI+CiAgICAgIDwvcGF0aD4KICAgICA8L3N2Zz4=" class="w-4 h-4 w-4 h-4" /> <img src="data:image/svg+xml;base64,PHN2ZyBjbGFzcz0idy00IGgtNCB3LTQgaC00IHRleHQtZ3JlZW4tNjAwIiBmaWxsPSJub25lIiBzdHJva2U9ImN1cnJlbnRDb2xvciIgdmlld2JveD0iMCAwIDI0IDI0Ij4KICAgICAgPHBhdGggc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBzdHJva2Utd2lkdGg9IjIiIGQ9Ik01IDEzbDQgNEwxOSA3Ij4KICAgICAgPC9wYXRoPgogICAgIDwvc3ZnPg==" class="w-4 h-4 w-4 h-4 text-green-600" /> <span x-text="copied ? 'Copied!' : 'Copy'"> </span>

</div>

</div>

<div id="wiki-content" class="prose prose-sm max-w-none scroll-smooth">

**Using Shipping Rule, you can define the cost for delivering the product to the customer or the supplier. Its a rule to define shipping charges applied to sales transactions**

Most of the companies (mainly retail) have a shipping charge applied based on the invoice total. You can setup Shipping Rule to address the requirement of varying shipping charges based on the Net Total of sales transactions. Use them to offer discounted shipping rates on high-value orders and standard rates on smaller ones.

To set up a Shipping Rule, go to:

`     Selling > Setup > Shipping Rule    ` or `     Accounts > Setup > Shipping Rule    `

## How to create a Shipping Rule

1.  Go to the Shipping Rule list, click on New.
2.  Enter the Shipping Rule label, for example, 'Priority Shipping' or 'Next Day Shipping'.
3.  When shipping charges are determined by a Shipping Rule, you must also provide the **Shipping Account** , **Cost Center** , and **Shipping Amount** . These details are required to populate the "Taxes and Other Charges" table in the transaction.
4.  Under Calculate Based On, you can also change the calculation on which the Shipping Rule will be applied, like net total quantity or net total weight; by default, it is "Fixed".
5.  Save

![Shipping Rule](/files/shipping-rule.png)

## Features

### Shipping Rule Conditions

On selecting Net Total or Net Weight, a table will appear where you can set the from and to values for the amount or weight. Enter the Shipping Amount to be calculated for the entered range. Add more conditions as necessary. You can select only one of the three calculation methods in one Shipping Rule.

![Shipping Rule Conditions](/files/shipping-rule-conditions.png)

Referring above, you will notice that shipping charges are reducing as the value increases. This shipping charge will only be applied if the transaction total falls under one of the above ranges.

### Valid for Countries

You can restrict the Shipping Rule to certain countries. Add the countries in the table. By default, the Shipping Rule will be applicable globally. If specific countries are mentioned, then Shipping Charges will be applied only if the Customer's country matches the country mentioned in the Shipping Rule.

![Country Specific Shipping Rules](/files/country-specific-shipping-rules.gif)

### Shipping Rule Application

Following is an example of how shipping charges are auto-applied on a Sales Order based on a Shipping Rule.

![Shipping Rule in Sales Order](/files/shipping-rule-in-sales-order.gif)

</div>

<div class="mt-8 flex flex-col sm:flex-row sm:items-start sm:justify-between gap-4">

<div id="wiki-last-updated" class="text-sm text-[var(--ink-gray-5)]" title="26-02-2026 21:23:22" timestamp="26-02-2026 21:23:22">

Last updated 2 months ago

</div>

</div>
