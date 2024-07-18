with
    source_salesorderdetails as (
        select
            cast(salesorderdetailid as int) as pk_salesorderdetailid
            , cast(salesorderid as int) as salesorderid
            , cast(productid as int) as productid
            , cast(specialofferid as int) as specialofferid
            , cast(orderqty as int) as od_orderqty
            , cast(unitprice as numeric(18,2)) as od_unitprice
            , cast(unitpricediscount as numeric(18,2)) as od_unitpricediscount

        from {{ source("snowflake", "salesorderdetail") }}

    )

select *
from source_salesorderdetails
