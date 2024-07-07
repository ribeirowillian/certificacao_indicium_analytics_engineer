WITH salesorderheaders AS (
    SELECT
        pk_salesorderid,
        fk_customerid,
        fk_salespersonid,
        fk_territoryid,
        fk_creditcardid,
        salesorderheader_orderdate,
        salesorderheader_status_description,
        salesorderheader_totaldue
    FROM {{ ref('stg_snowflake__salesorderheaders') }}
),
salesreasons AS (
    SELECT
        pk_salesreasonid,
        name_salesreason
    FROM {{ ref('stg_snowflake__salesreasons') }}
),
salesorderheadersalesreasons AS (
    SELECT
        pk_salesorderid,
        fk_salesreasonid
    FROM {{ ref('stg_snowflake__salesorderheadersalesreasons') }}
),
order_reasons AS (
    SELECT
        soh.pk_salesorderid,
        soh.salesorderheader_orderdate,
        soh.salesorderheader_status_description,
        soh.salesorderheader_totaldue,
        sr.pk_salesreasonid,
        sr.name_salesreason
    FROM
        salesorderheaders soh
    LEFT JOIN
        salesorderheadersalesreasons sohsr ON soh.pk_salesorderid = sohsr.pk_salesorderid
    LEFT JOIN
        salesreasons sr ON sohsr.fk_salesreasonid = sr.pk_salesreasonid
)
SELECT * FROM order_reasons
