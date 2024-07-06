-- models/joined_address_data.sql

WITH address AS (
    SELECT
        pk_addressid,
        address_addressline1,
        address_city,
        fk_stateprovinceid,
        address_postalcode
    FROM {{ ref('stg_snowflake__address') }}
),

stateprovinces AS (
    SELECT
        pk_stateprovinceid,
        fk_territoryid,
        fk_stateprovinces_stateprovincecode,
        stateprovinces_countryregioncode,
        stateprovinces_name
    FROM {{ ref('stg_snowflake__stateprovinces') }}
),

countryregions AS (
    SELECT
        pk_countryregioncode,
        countryregion_name
    FROM {{ ref('stg_snowflake__countryregions') }}
)

SELECT
    a.pk_addressid,
    a.address_addressline1,
    a.address_city,
    a.address_postalcode,
    sp.stateprovinces_name,
    cr.countryregion_name
FROM address a
LEFT JOIN stateprovinces sp ON a.fk_stateprovinceid = sp.pk_stateprovinceid
LEFT JOIN countryregions cr ON sp.stateprovinces_countryregioncode = cr.pk_countryregioncode
