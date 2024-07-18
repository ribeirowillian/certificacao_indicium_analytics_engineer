with
    source_customers as (
        select
            cast(customerid as int) as pk_customerid
            , cast(territoryid as int) as territory_id
            , cast(personid as int) as person_id

        from {{ source("snowflake", "customer") }}

    )

select *
from source_customers
