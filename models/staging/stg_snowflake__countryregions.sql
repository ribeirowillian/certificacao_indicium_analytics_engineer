with
    source_countryregions as (
        select
            countryregioncode as pk_countryregioncode
            , name as name_country

        from {{ source("snowflake", "countryregion") }}
    )
select *
from source_countryregions
