with
    source_customers as (
        select
            cast(customerid as int) as pk_customerid
            , cast(territoryid as int) as territoryid
            , cast(personid as int) as personid

        from {{ source("snowflake", "customer") }}
    )
select *
from source_customers
