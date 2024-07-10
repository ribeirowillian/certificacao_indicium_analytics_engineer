WITH fact_sales_keys_only AS (
    SELECT
        oi.FK_CUSTOMERID,
        oi.fk_addressid,
        oi.FK_SALESPERSONID,
        oi.FK_TERRITORYID,
        oi.FK_CREDITCARDID,
        oi.OH_ORDERDATE,
        oi.OH_STATUS,
        oi.PK_SALESORDERDETAILID,
        oi.FK_PRODUCTID,
        oi.FK_SPECIALOFFERID,
        oi.OD_ORDERQTY,
        oi.OD_UNITPRICE,
        oi.OD_UNITPRICEDISCOUNT,
        oi.FREIGHT_PER_ITEM,
        oi.TAX_PER_ITEM,
        oi.ITEM_TOTAL,
        oi.DISCOUNTED_ITEM_TOTAL,
        oi.OH_TOTALDUE
    FROM {{ ref('dim_ordered_items') }} oi
)
SELECT * FROM fact_sales_keys_only
