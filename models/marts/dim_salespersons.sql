SELECT
    PK_BUSINESSENTITYID,
    FK_TERRITORYID
FROM {{ ref('stg_snowflake__salespersons') }}
