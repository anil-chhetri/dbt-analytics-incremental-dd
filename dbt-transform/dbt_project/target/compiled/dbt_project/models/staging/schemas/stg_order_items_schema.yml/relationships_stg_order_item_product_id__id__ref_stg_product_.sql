
    
    

with child as (
    select product_id as from_field
    from "dev"."staging"."stg_order_item"
    where product_id is not null
),

parent as (
    select id as to_field
    from "dev"."staging"."stg_product"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


