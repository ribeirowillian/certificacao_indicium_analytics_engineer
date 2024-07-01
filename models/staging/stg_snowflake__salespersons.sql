with
    source_salespersons as (
        select
            cast(businessentityid as int) as pk_businessentityid
            , cast(territoryid as int) as fk_territoryid

        from {{ source("snowflake", "salesperson") }}

    )

select *
from source_salespersons
