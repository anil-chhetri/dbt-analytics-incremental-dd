{%- macro cleaning_phone_number(phone_number) -%}

    {{- log("DEBUG: Received column = " ~ phone_number, info=False) -}}
    {{- log("DEBUG: All positional args (varargs) = " ~ varargs | list, info=False) -}}
    {{- log("DEBUG: All keyword args (kwargs) = " ~ kwargs, info=False) -}}


    right('00' || regexp_replace({{ phone_number }}, '[^0-9]', '', 'g'), 10)
{%- endmacro %}