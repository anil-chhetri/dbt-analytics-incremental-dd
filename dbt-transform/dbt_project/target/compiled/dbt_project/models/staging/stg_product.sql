

with cte as (
    select 
        product_id as id,
        product_name,
        category,
        price,
        stock_quantity
    from "dev"."raw"."products"
)

select * from cte