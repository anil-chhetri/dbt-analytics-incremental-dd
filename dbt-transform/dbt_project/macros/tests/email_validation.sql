{{config(
    severity='error',
    tags=['email_validation']
)}}

{%- test email_validation(model, column_name) -%}

    {{ log("Running email validation test on " ~ model ~ "." ~ column_name, info=True) }}
    select
        *
    from {{ model }}
    where {{ column_name }} is not null
      and regexp_matches({{ column_name }}, '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
{%- endtest -%}