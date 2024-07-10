SELECT
    PK_SALESREASONID,
    FK_CUSTOMERID,
    FK_SALESPERSONID,
    FK_TERRITORYID,
    FK_CREDITCARDID,
    REASON_FOR_SALE
FROM {{ ref('int_snowflake__salesreasons') }}
