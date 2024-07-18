with salesorderheaders as (
    select
        pk_salesorderid
        , addressid as fk_addressid
        , customerid as fk_customerid
        , salespersonid as fk_salespersonid
        , territoryid as fk_territoryid
        , creditcardid as fk_creditcardid
        , oh_orderdate
        , oh_status
        , oh_status_description
        , oh_freight
        , oh_taxamt
        , oh_totaldue
        , oh_subtotal
    from {{ ref('stg_snowflake__salesorderheaders') }}
),

salesorderdetails as (
    select
        pk_salesorderdetailid
        , salesorderid as fk_salesorderid
        , productid as fk_productid
        , specialofferid as fk_specialofferid
        , od_orderqty
        , od_unitprice
        , od_unitpricediscount
    from {{ ref('stg_snowflake__salesorderdetails') }}
),

total_items_per_order as (
    select
        fk_salesorderid
        , sum(od_orderqty) as total_order_qty
    from salesorderdetails
    group by fk_salesorderid
),

order_items as (
    select
        soh.pk_salesorderid
        , soh.fk_addressid
        , soh.fk_customerid
        , soh.fk_salespersonid
        , soh.fk_territoryid
        , soh.fk_creditcardid
        , soh.oh_orderdate
        , soh.oh_status
        , soh.oh_status_description
        , soh.oh_freight
        , soh.oh_taxamt
        , soh.oh_totaldue
        , soh.oh_subtotal
        , sod.pk_salesorderdetailid
        , sod.fk_productid
        , sod.fk_specialofferid
        , sod.od_orderqty
        , sod.od_unitprice
        , sod.od_unitpricediscount
        , cast((soh.oh_freight / ti.total_order_qty) * sod.od_orderqty as numeric(18,2)) as freight_per_item
        , cast((soh.oh_taxamt / ti.total_order_qty) * sod.od_orderqty as numeric(18,2)) as tax_per_item
        , cast(sod.od_unitprice * sod.od_orderqty as numeric(18,2)) as item_subtotal
        , cast((sod.od_unitprice * (1 - sod.od_unitpricediscount)) * sod.od_orderqty as numeric(18,2)) as discounted_item_subtotal
        , case
            when soh.fk_creditcardid is null or soh.fk_creditcardid = 0 then 'outra forma de pagamento'
            else cast(soh.fk_creditcardid as string)
        end as creditcard_display
    from
        salesorderheaders soh
    left join
        salesorderdetails sod on soh.pk_salesorderid = sod.fk_salesorderid
    left join
        total_items_per_order ti on soh.pk_salesorderid = ti.fk_salesorderid
)

select
    pk_salesorderid
    , fk_addressid
    , fk_customerid
    , fk_salespersonid
    , fk_territoryid
    , fk_creditcardid
    , creditcard_display
    , oh_orderdate
    , oh_status
    , oh_status_description
    , pk_salesorderdetailid
    , fk_productid
    , fk_specialofferid
    , od_orderqty
    , od_unitprice
    , od_unitpricediscount
    , freight_per_item
    , tax_per_item
    , item_subtotal + freight_per_item + tax_per_item as item_total
    , discounted_item_subtotal as discounted_item_total
    , oh_totaldue
from
    order_items
