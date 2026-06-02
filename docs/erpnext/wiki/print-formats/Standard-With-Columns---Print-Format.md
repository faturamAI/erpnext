```
DocType = { The DocType where you want to use this }
Module = { Module of given DocType }
Standard = No
Print Format Type = Server
Name: { DocType } - Standard With Columns
```

##### HTML
```
{% if doc.items -%}
{% for d in doc.items %}
{% if d.get("print_templates") -%}
{% if "description" in d.get("print_templates") and d.get("print_templates").pop("description") %}{% endif %}
{% if "item_code" in d.get("hide_in_print_layout", []) and d.get("hide_in_print_layout").remove("item_code") %}{% endif %}
{% if "item_name" in d.get("hide_in_print_layout", []) and d.get("hide_in_print_layout").remove("item_name") %}{% endif %}
{% if "image" in d.get("hide_in_print_layout", []) and d.get("hide_in_print_layout").remove("image") %}{% endif %}
{% endif %}
{% endfor %}
{%- endif %}
{% include "templates/print_formats/standard.html" %}
```