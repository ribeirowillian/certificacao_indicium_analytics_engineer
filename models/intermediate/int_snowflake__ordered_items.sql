WITH salesorderheaders AS (
    SELECT
        pk_salesorderid,
        fk_customerid,
        fk_salespersonid,
        fk_territoryid,
        fk_creditcardid,
        salesorderheader_orderdate,
        salesorderheader_status,
        salesorderheader_freight,
        salesorderheader_taxamt,
        salesorderheader_totaldue,
        salesorderheader_subtotal
    FROM {{ ref('stg_snowflake__salesorderheaders') }}
),

salesorderdetails AS (
    SELECT
        pk_salesorderdetailid,
        fk_salesorderid,
        fk_productid,
        fk_specialofferid,
        salesorderdetails_orderqty,
        salesorderdetails_unitprice,
        salesorderdetails_unitpricediscount
    FROM {{ ref('stg_snowflake__salesorderdetails') }}
),

total_items_per_order AS (
    SELECT
        fk_salesorderid,
        SUM(salesorderdetails_orderqty) AS total_order_qty
    FROM salesorderdetails
    GROUP BY fk_salesorderid
),

order_items AS (
    SELECT
        soh.pk_salesorderid,
        soh.salesorderheader_orderdate,
        soh.salesorderheader_status,
        soh.salesorderheader_freight,
        soh.salesorderheader_taxamt,
        soh.salesorderheader_totaldue,
        soh.salesorderheader_subtotal,
        sod.pk_salesorderdetailid,
        sod.fk_productid,
        sod.fk_specialofferid,
        sod.salesorderdetails_orderqty,
        sod.salesorderdetails_unitprice,
        sod.salesorderdetails_unitpricediscount,
        CAST((soh.salesorderheader_freight / ti.total_order_qty) * sod.salesorderdetails_orderqty AS NUMERIC(18,2)) AS freight_per_item,
        CAST((soh.salesorderheader_taxamt / ti.total_order_qty) * sod.salesorderdetails_orderqty AS NUMERIC(18,2)) AS tax_per_item,
        CAST(sod.salesorderdetails_unitprice * sod.salesorderdetails_orderqty AS NUMERIC(18,2)) AS item_subtotal
    FROM
        salesorderheaders soh
    LEFT JOIN
        salesorderdetails sod ON soh.pk_salesorderid = sod.fk_salesorderid
    LEFT JOIN
        total_items_per_order ti ON soh.pk_salesorderid = ti.fk_salesorderid
)

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
    item_subtotal + freight_per_item + tax_per_item AS item_total,
    salesorderheader_totaldue
FROM
    order_items
