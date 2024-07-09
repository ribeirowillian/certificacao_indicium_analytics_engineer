with
    source_countryregions as (
        select
            cast(countryregioncode as string) as pk_countryregioncode
            , cast(name as string) as name_country

        from {{ source("snowflake", "countryregion") }}

    )

select *
from source_countryregions
