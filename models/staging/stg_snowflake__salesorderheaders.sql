with
    source_salesorderheaders as (
        select
            cast(salesorderid as int) as pk_salesorderid
            , cast(shiptoaddressid as int) as addressid
            , cast(customerid as int) as customerid
            , cast(salespersonid as int) as salespersonid
            , cast(territoryid as int) as territoryid
            , cast(creditcardid as int) as creditcardid
            , cast(orderdate as date) as oh_orderdate
            , cast(status as int) as oh_status
            , case
                when cast(status as int) = 1
                then 'Em progresso'
                when cast(status as int) = 2
                then 'Aprovado'
                when cast(status as int) = 3
                then 'Pedido em espera'
                when cast(status as int) = 4
                then 'Rejeitado'
                when cast(status as int) = 5
                then 'Enviado'
                when cast(status as int) = 6
                then 'Calcelado'
                else 'Unknown'
            end as oh_status_description
            , cast(subtotal as numeric(18, 2)) as oh_subtotal
            , cast(freight as numeric(18, 2)) as oh_freight
            , cast(taxamt as numeric(18, 2)) as oh_taxamt
            , cast(totaldue as numeric(18, 2)) as oh_totaldue

        from {{ source("snowflake", "salesorderheader") }}

    )

select *
from source_salesorderheaders
