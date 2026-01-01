

with cte as (
    select 
        order_item_id as id,
        order_id,
        product_id,
        quantity,
        price
    from "dev"."raw"."order_items"
)

select
    *
from cte