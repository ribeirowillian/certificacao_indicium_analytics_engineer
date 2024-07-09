with
    source_salesorderdetails as (
        select
            cast(salesorderdetailid as varchar) as pk_salesorderdetailid
            , cast(salesorderid as int) as fk_salesorderid
            , cast(productid as int) as fk_productid
            , cast(specialofferid as int) as fk_specialofferid
            , cast(orderqty as varchar) as od_orderqty
            , cast(unitprice as varchar) as od_unitprice
            , cast(unitpricediscount as varchar) as od_unitpricediscount

        from {{ source("snowflake", "salesorderdetail") }}

    )

select *
from source_salesorderdetails
