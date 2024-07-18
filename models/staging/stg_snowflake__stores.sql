with
    source_stores as (
        select
            cast(businessentityid as int) as pk_businessentityid
            , cast(salespersonid as int) as salespersonid
            , name as name_store

        from {{ source("snowflake", "store") }}

    )

select *
from source_stores
