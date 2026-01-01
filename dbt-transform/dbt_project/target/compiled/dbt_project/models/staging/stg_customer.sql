

with cte as (
    select
        customer_id as id,
        first_name,
        last_name,
        email,
        right('00' || regexp_replace(phone_number, '[^0-9]', '', 'g'), 10) as phone_number,
        address,
        created_at
    from "dev"."raw"."customers"
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

