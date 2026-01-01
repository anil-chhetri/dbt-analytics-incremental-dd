{{
    config(
        materialized = 'incremental',
        unique_key = 'id',
        incremental_strategy = 'delete_insert',
        on_schema_change = 'append_new_columns',
        schema='staging',
        tags=['staging']
    )
}}

with cte as (
    select 
        product_id as id,
        product_name,
        category,
        price,
        stock_quantity
    from {{ source('source_data', 'products') }}
)

select * from cte