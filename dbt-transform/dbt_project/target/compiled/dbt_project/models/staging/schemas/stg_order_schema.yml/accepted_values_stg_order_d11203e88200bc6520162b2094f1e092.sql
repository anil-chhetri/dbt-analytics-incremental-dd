
    
    

with all_values as (

    select
        delivery_status as value_field,
        count(*) as n_records

    from "dev"."staging"."stg_order"
    group by delivery_status

)

select *
from all_values
where value_field not in (
    'pending','shipped','delivered','canceled'
)


