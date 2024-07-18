with
    source_salesterritorys as (
        select
            cast(territoryid as int) as pk_territoryid
            , name as st_name
            , countryregioncode as st_countryregioncode
            , group_ as st_group
            , cast(salesytd as numeric(18,2)) as st_salesytd
            , cast(saleslastyear as numeric(18,2)) as st_saleslastyear
        from {{ source("snowflake", "salesterritory") }}
    )
select *
from source_salesterritorys
