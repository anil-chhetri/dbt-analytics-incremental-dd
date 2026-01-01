{{
    config(
        materialized='table',
        schema='staging',
        tags=['staging']
    )
}}

with cte as (
    select 
        order_id as id,
        customer_id,
        order_date,
        "status" as delivery_status,
        amount
    from {{ source('source_data', 'orders') }}
)

select * from cte