

with cte as (
    select 
        order_id as id,
        customer_id,
        order_date,
        "status" as delivery_status,
        amount
    from "dev"."raw"."orders"
)

select * from cte