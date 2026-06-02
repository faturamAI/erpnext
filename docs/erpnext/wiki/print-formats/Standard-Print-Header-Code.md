```
<div class="print-heading">
	<h2>{{ doc.select_print_heading or (doc.print_heading if doc.print_heading != None
		else _(doc.doctype)) }}<br>
		<small>{{ doc.sub_heading if doc.sub_heading != None
			else doc.name }}</small>
    </h2>
</div>
```