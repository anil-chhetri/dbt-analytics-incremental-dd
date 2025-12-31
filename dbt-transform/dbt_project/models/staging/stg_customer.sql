{{config(
    materialized='incremental',
    incremental_strategy='merge',
    schema='staging',
    unique_key='id',
    on_schema_change='append_new_columns',
    tags=['staging']
)}}

with cte as (
    select
        customer_id as id,
        first_name,
        last_name,
        email,
        {{ cleaning_phone_number("phone_number") }} as phone_number,
        address,
        created_at
    from {{ source('source_data', 'customers') }}
)

select
    id,
    first_name,
    last_name,
    regexp_replace(lower(email), '[^a-zA-Z.@]', '') as email,
    phone_number,
    address,
    created_at
from cte

{% if is_incremental() %}
    where created_at > (select max(created_at) from {{ this }})
{% endif %}