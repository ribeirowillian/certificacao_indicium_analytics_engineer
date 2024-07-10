SELECT
    FK_CUSTOMERID,
    FK_SALESPERSONID,
    FK_TERRITORYID,
    FK_CREDITCARDID,
    PK_SALESREASONID,
    REASON_FOR_SALE
FROM {{ ref('int_snowflake__salesreasons') }}
