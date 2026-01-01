{{config(
    severity='error',
    tags=['check_negative_value']
)}}


{%- test check_negative_value(model, column_name) -%}

  {{- log("DEBUG: Received column = " ~ column_name, info=False) -}}
    {{- log("DEBUG: All positional args (varargs) = " ~ varargs | list, info=False) -}}
    {{- log("DEBUG: All keyword args (kwargs) = " ~ kwargs, info=False) -}}

    select * from {{ model }} where {{ column_name }} < 0

{%- endtest -%}