with
    source_salesreasons as (
        select
            cast(salesreasonid as int) as pk_salesreasonid
            , name as reason_for_sale
        from {{ source("snowflake", "salesreason") }}
    )
select *
from source_salesreasons
