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
            ,CASE
                WHEN CAST(status AS INT) = 1 THEN 'Em progresso'
                WHEN CAST(status AS INT) = 2 THEN 'Aprovado'
                WHEN CAST(status AS INT) = 3 THEN 'Pedido em espera'
                WHEN CAST(status AS INT) = 4 THEN 'Rejeitado'
                WHEN CAST(status AS INT) = 5 THEN 'Enviado'
                WHEN CAST(status AS INT) = 6 THEN 'Calcelado'
                ELSE 'Unknown'
            END AS salesorderheader_status_description 
            , cast(totaldue as numeric(18,2)) as salesorderheader_totaldue

        from {{ source("snowflake", "salesorderheader") }}

    )

select *
from source_salesorderheaders
