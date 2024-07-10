WITH dim_address AS (
    SELECT
        PK_ADDRESSID,
        ADDRESS,
        CITY,
        POSTALCODE,
        SP_NAME_STATEPROVINCE,
        NAME_COUNTRY
    FROM {{ ref('dim_address') }}
),

dim_clients AS (
    SELECT
        PK_CLIENTE,
        CD_CLIENTE,
        CD_LOJA,
        CD_PESSOA,
        CD_VENDEDOR_ATRIBUIDO,
        TP_CLIENTE,
        NM_VENDEDOR_ATRIBUIDO,
        NM_CLIENTE
    FROM {{ ref('dim_clients') }}
),

dim_creditcards AS (
    SELECT
        PK_BUSINESSENTITYID,
        PK_CREDITCARDID,
        FK_CREDITCARDID,
        CARDTYPE
    FROM {{ ref('dim_creditcards') }}
),

dim_ordered_items AS (
    SELECT
        FK_CUSTOMERID,
        FK_SALESPERSONID,
        FK_TERRITORYID,
        FK_CREDITCARDID,
        OH_ORDERDATE,
        OH_STATUS,
        PK_SALESORDERDETAILID,
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
    FROM {{ ref('dim_ordered_items') }}
),

dim_products AS (
    SELECT
        PK_PRODUCT,
        FK_PRODUCTSUBCATEGORYID,
        FK_PRODUCTMODELID,
        NAME_PRODUCT,
        COLOR,
        SIZES,
        NAME_SUBCATEGORY,
        NAME_CATEGORY
    FROM {{ ref('dim_products') }}
),

dim_salesperson AS (
    SELECT
        PK_BUSINESSENTITYID,
        FK_TERRITORYID
    FROM {{ ref('dim_salespersons') }}
),

dim_salesreason AS (
    SELECT
        FK_CUSTOMERID,
        FK_SALESPERSONID,
        FK_TERRITORYID,
        FK_CREDITCARDID,
        PK_SALESREASONID,
        REASON_FOR_SALE
    FROM {{ ref('dim_salesreasons') }}
),

fact_sales AS (
    SELECT
        oi.FK_CUSTOMERID,
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
        oi.OH_TOTALDUE,
        c.NM_CLIENTE,
        cc.CARDTYPE,
        cc.CARDNUMBER,
        p.NAME_PRODUCT,
        p.COLOR,
        p.SIZES,
        sp.NAME_SALESPERSON,
        sr.NAME_SALESREASON,
        a.ADDRESS,
        a.CITY,
        a.POSTALCODE,
        a.SP_NAME_STATEPROVINCE,
        a.NAME_COUNTRY
    FROM
        dim_ordered_items oi
    LEFT JOIN dim_clients c ON oi.FK_CUSTOMERID = c.cd_CLIENTE
    LEFT JOIN dim_creditcards cc ON oi.FK_CREDITCARDID = cc.PK_CLIENTE
    LEFT JOIN dim_products p ON oi.FK_PRODUCTID = p.PK_PRODUCT
    LEFT JOIN dim_salesperson sp ON oi.FK_SALESPERSONID = sp.PK_BUSINESSENTITYID
    LEFT JOIN dim_salesreason sr ON oi.FK_SPECIALOFFERID = sr.PK_BUSINESSENTITYID
    LEFT JOIN dim_address a ON oi.FK_CUSTOMERID = a.PK_ADDRESSID
)

SELECT * FROM fact_sales
