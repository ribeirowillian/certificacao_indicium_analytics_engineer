with
    address as (
        select pk_addressid, fk_stateprovinceid, address, city, postalcode
        from {{ ref("stg_snowflake__address") }}
    ),

    stateprovinces as (
        select
            pk_stateprovinceid,
            fk_territoryid,
            sp_stateprovincecode,
            sp_countryregioncode,
            sp_name_stateprovince
        from {{ ref("stg_snowflake__stateprovinces") }}
    ),

    countryregions as (
        select pk_countryregioncode, name_country
        from {{ ref("stg_snowflake__countryregions") }}
    )

select
    a.pk_addressid,
    a.address,
    a.city,
    a.postalcode,
    sp.sp_name_stateprovince,
    cr.name_country
from address a
left join stateprovinces sp on a.fk_stateprovinceid = sp.pk_stateprovinceid
left join countryregions cr on sp.sp_countryregioncode = cr.pk_countryregioncode
