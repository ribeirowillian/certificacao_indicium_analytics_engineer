WITH fact_sales_keys_only AS (
    SELECT    
        PK_SALESORDERDETAILID,
        FK_ADDRESSID,
        PK_SALESORDERID,
        FK_CUSTOMERID,
        FK_SALESPERSONID,
        FK_TERRITORYID,
        FK_CREDITCARDID,
        creditcard_display,
        OH_ORDERDATE,
        OH_STATUS,
        FK_PRODUCTID,
        FK_SPECIALOFFERID,
        OD_ORDERQTY,
        OD_UNITPRICE,
        OD_UNITPRICEDISCOUNT,
        FREIGHT_PER_ITEM,
        TAX_PER_ITEM,
        ITEM_TOTAL,
        DISCOUNTED_ITEM_TOTAL,
        OH_TOTALDUE
    FROM {{ ref('dim_ordered_items') }} oi
)
SELECT * FROM fact_sales_keys_only
