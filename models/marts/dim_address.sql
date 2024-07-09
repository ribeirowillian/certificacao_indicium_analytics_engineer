SELECT
    PK_ADDRESSID,
    ADDRESS,
    CITY,
    POSTALCODE,
    SP_NAME_STATEPROVINCE,
    NAME_COUNTRY
FROM {{ ref('int_snowflake__address') }}
