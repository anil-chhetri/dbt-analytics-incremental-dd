

select phone_number from "dev"."staging"."stg_customer"
where phone_number is null 
or length(phone_number) <> 10