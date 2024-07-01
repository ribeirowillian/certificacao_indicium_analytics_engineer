with
    source_stateprovinces as (
        select
            cast(stateprovinceid as int) as pk_stateprovinceid
            , cast(territoryid as int) as fk_territoryid
            , cast(stateprovincecode as varchar) as fk_stateprovinces_stateprovincecode
            , cast(countryregioncode as varchar) as stateprovinces_countryregioncode
            , cast(name as varchar) as stateprovinces_name
            
        from {{ source("snowflake", "stateprovince") }}

    )

select *
from source_stateprovinces
