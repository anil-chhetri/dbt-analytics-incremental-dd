
    
    select
        *
    from "dev"."staging"."stg_customer"
    where email is not null
      and not regexp_matches(email, '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')