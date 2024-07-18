with
    source_stateprovinces as (
        select
            cast(stateprovinceid as int) as pk_stateprovinceid
            , cast(territoryid as int) as territoryid
            , stateprovincecode as sp_stateprovincecode
            , countryregioncode as sp_countryregioncode
            , name as sp_name_stateprovince
        from {{ source("snowflake", "stateprovince") }}
    )
select *
from source_stateprovinces
