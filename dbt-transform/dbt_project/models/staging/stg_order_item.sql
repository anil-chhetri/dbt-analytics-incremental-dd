{{ config(
    materialized='table',
    schema='staging',
    tags=['staging']
)}}

with cte as (
    select 
        order_item_id as id,
        order_id,
        product_id,
        quantity,
        price
    from {{ source('source_data', 'order_items') }}
)

select
    *
from cte