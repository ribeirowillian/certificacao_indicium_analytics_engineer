with
    source_countryregions as (
        select
            cast(countryregioncode as varchar) as pk_countryregioncode
            , cast(name as varchar) as coutryregion_name

        from {{ source("snowflake", "countryregion") }}

    )

select *
from source_countryregions
