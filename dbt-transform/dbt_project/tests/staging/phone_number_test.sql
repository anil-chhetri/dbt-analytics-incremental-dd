{{ 
    config(severity='error', 
        save_failures=true, 
        schema='testing',
        limit=10
    ) 
}}

select phone_number from {{ ref('stg_customer') }}
where phone_number is null 
or length(phone_number) <> 10