with
    source_salesterritorys as (
        select
            cast(territoryid as int) as pk_territoryid
            , cast(name as varchar) as st_name
            , cast(countryregioncode as varchar) as st_countryregioncode
            , cast(group_ as varchar) as st_group
            , cast(salesytd as numeric(18,2)) as st_salesytd
            , cast(saleslastyear as numeric(18,2)) as st_saleslastyear

        from {{ source("snowflake", "salesterritory") }}

    )

select *
from source_salesterritorys
