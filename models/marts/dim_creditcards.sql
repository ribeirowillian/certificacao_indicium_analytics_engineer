SELECT
    PK_BUSINESSENTITYID,
    FK_CREDITCARDID,
    CARDTYPE,
    
FROM {{ ref('int_snowflake__creditcards') }}
