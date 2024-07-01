with
    source_salesorderheaders as (
        select
            cast(salesorderid as int) as pk_salesorderid
            , cast(customerid as int) as fk_customerid
            , cast(salespersonid as int) as fk_salespersonid
            , cast(territoryid as int) as fk_territoryid
            , cast(creditcardid as int) as fk_creditcardid
            , cast(orderdate as varchar) as salesorderheader_orderdate
            , cast(status as int) as salesorderheader_status
            , cast(totaldue as varchar) as salesorderheader_totaldue
            , cast(subtotal as varchar) as salesorderheader_subtotal

        from {{ source("snowflake", "salesorderheader") }}

    )

select *
from source_salesorderheaders
