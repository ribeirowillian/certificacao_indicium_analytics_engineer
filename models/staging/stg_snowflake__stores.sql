with
    source_stores as (
        select
            cast(businessentityid as int) as pk_businessentityid
            , cast(salespersonid as varchar) as fk_salespersonid
            , cast(name as varchar) as name_store

        from {{ source("snowflake", "store") }}

    )

select *
from source_stores
