-- models/marts/dim_ordered_items.sql

SELECT
    pk_salesorderid,
    salesorderheader_orderdate,
    salesorderheader_status,
    pk_salesorderdetailid,
    fk_productid,
    fk_specialofferid,
    salesorderdetails_orderqty,
    salesorderdetails_unitprice,
    salesorderdetails_unitpricediscount,
    freight_per_item,
    tax_per_item,
    item_subtotal,
    item_subtotal + freight_per_item + tax_per_item AS item_total,
    salesorderheader_totaldue
FROM
    {{ ref('int_snowflake__ordered_items') }}
