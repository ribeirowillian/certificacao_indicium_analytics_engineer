SELECT
    PK_BUSINESSENTITYID,
    PK_CREDITCARDID,
    FK_CREDITCARDID,
    CARDTYPE
FROM {{ ref('int_snowflake__creditcards') }}
