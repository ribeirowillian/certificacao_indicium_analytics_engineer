with
    source_customers as (
        select
            cast(customerid as int) as pk_customerid
            , cast(territoryid as int) as fk_territoryid
            , cast(personid as int) as fk_personid

        from {{ source("snowflake", "customer") }}

    )

select *
from source_customers
