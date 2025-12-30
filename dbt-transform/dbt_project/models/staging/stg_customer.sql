{{config(
    materialized='table',
    schema='staging',
    tags=['staging']
)}}

with cte as (
    select
        customer_id as id,
        first_name,
        last_name,
        email,
        address,
        created_at
    from {{ source('source_data', 'customers') }}
)

select
    id,
    first_name,
    last_name,
    regexp_replace(lower(email), '[^a-zA-Z.@]', '') as email,
    address,
    created_at
from cte