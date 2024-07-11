SELECT
    PK_SALESORDERID,
    PK_SALESREASONID,
    FK_CUSTOMERID,
    FK_SALESPERSONID,
    MOTIVO_DA_VENDA
FROM {{ ref('int_snowflake__salesreasons') }}
