WITH salesorderheaders AS (
    SELECT
        pk_salesorderid,
        fk_addressid,
        fk_customerid,
        fk_salespersonid,
        fk_territoryid,
        fk_creditcardid,
        oh_orderdate,
        oh_status,
        OH_STATUS_DESCRIPTION,
        oh_freight,
        oh_taxamt,
        oh_totaldue,
        oh_subtotal
    FROM {{ ref('stg_snowflake__salesorderheaders') }}
),

salesorderdetails AS (
    SELECT
        pk_salesorderdetailid,
        fk_salesorderid,
        fk_productid,
        fk_specialofferid,
        od_orderqty,
        od_unitprice,
        od_unitpricediscount
    FROM {{ ref('stg_snowflake__salesorderdetails') }}
),

total_items_per_order AS (
    SELECT
        fk_salesorderid,
        SUM(od_orderqty) AS total_order_qty
    FROM salesorderdetails
    GROUP BY fk_salesorderid
),

order_items AS (
    SELECT
        soh.pk_salesorderid,
        soh.fk_addressid,
        soh.fk_customerid,
        soh.fk_salespersonid,
        soh.fk_territoryid,
        soh.fk_creditcardid,
        soh.oh_orderdate,
        soh.oh_status,
        OH_STATUS_DESCRIPTION,
        soh.oh_freight,
        soh.oh_taxamt,
        soh.oh_totaldue,
        soh.oh_subtotal,
        sod.pk_salesorderdetailid,
        sod.fk_productid,
        sod.fk_specialofferid,
        sod.od_orderqty,
        sod.od_unitprice,
        sod.od_unitpricediscount,
        CAST((soh.oh_freight / ti.total_order_qty) * sod.od_orderqty AS NUMERIC(18,2)) AS freight_per_item,
        CAST((soh.oh_taxamt / ti.total_order_qty) * sod.od_orderqty AS NUMERIC(18,2)) AS tax_per_item,
        CAST(sod.od_unitprice * sod.od_orderqty AS NUMERIC(18,2)) AS item_subtotal,
        CAST((sod.od_unitprice * (1 - sod.od_unitpricediscount)) * sod.od_orderqty AS NUMERIC(18,2)) AS discounted_item_subtotal
    FROM
        salesorderheaders soh
    LEFT JOIN
        salesorderdetails sod ON soh.pk_salesorderid = sod.fk_salesorderid
    LEFT JOIN
        total_items_per_order ti ON soh.pk_salesorderid = ti.fk_salesorderid
)

SELECT
    pk_salesorderid,
    fk_addressid,
    fk_customerid,
    fk_salespersonid,
    fk_territoryid,
    fk_creditcardid,
    oh_orderdate,
    oh_status,
    OH_STATUS_DESCRIPTION,
    pk_salesorderdetailid,
    fk_productid,
    fk_specialofferid,
    od_orderqty,
    od_unitprice,
    od_unitpricediscount,
    freight_per_item,
    tax_per_item,
    item_subtotal + freight_per_item + tax_per_item AS item_total,
    discounted_item_subtotal AS discounted_item_total,
    oh_totaldue
FROM
    order_items
