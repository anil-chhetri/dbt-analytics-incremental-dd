
    
    

select
    email as unique_field,
    count(*) as n_records

from "dev"."staging"."stg_customer"
where email is not null
group by email
having count(*) > 1


