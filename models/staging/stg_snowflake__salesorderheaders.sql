with
    source_salesorderheaders as (
        select
            cast(salesorderid as int) as pk_salesorderid
            , cast(customerid as int) as fk_customerid
            , cast(salespersonid as int) as fk_salespersonid
            , cast(territoryid as int) as fk_territoryid
            , cast(creditcardid as int) as fk_creditcardid
            , cast(orderdate as DATE) as salesorderheader_orderdate
            , cast(status as int) as salesorderheader_status
            , cast(totaldue as numeric(18,2)) as salesorderheader_totaldue

        from {{ source("snowflake", "salesorderheader") }}

    )

select *
from source_salesorderheaders
