with
    source_stateprovinces as (
        select
            cast(stateprovinceid as int) as pk_stateprovinceid
            , cast(territoryid as int) as fk_territoryid
            , cast(stateprovincecode as varchar) as sp_stateprovincecode
            , cast(countryregioncode as varchar) as sp_countryregioncode
            , cast(name as varchar) as sp_name_stateprovince
        from {{ source("snowflake", "stateprovince") }}

    )

select *
from source_stateprovinces
