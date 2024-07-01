with
    source_salesorderheadersalesreasons as (
        select
            cast(salesorderid as int) as pk_salesorderid
            , cast(salesreasonid as int) as fk_salesreasonid

        from {{ source("snowflake", "salesorderheadersalesreason") }}

    )

select *
from source_salesorderheadersalesreasons
