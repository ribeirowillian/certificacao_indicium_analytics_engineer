with
    source_salespersons as (
        select
            cast(businessentityid as int) as pk_businessentityid
            , cast(territoryid as int) as territoryid
        from {{ source("snowflake", "salesperson") }}
    )
select *
from source_salespersons
