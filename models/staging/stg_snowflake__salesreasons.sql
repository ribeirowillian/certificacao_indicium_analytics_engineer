with
    source_salesreasons as (
        select
            cast(salesreasonid as int) as pk_salesreasonid
            , cast(name as varchar) as name_salesreason
        from {{ source("snowflake", "salesreason") }}

    )

select *
from source_salesreasons
