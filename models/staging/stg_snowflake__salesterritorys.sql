with
    source_salesterritorys as (
        select
            cast(territoryid as int) as pk_territoryid
            , cast(name as varchar) as salesterritorys_name
            , cast(countryregioncode as varchar) as salesterritorys_countryregioncode
            , cast(group_ as varchar) as salesterritorys_group
            , cast(salesytd as varchar) as salesterritorys_salesytd
            , cast(saleslastyear as varchar) as salesterritorys_saleslastyear

        from {{ source("snowflake", "salesterritory") }}

    )

select *
from source_salesterritorys
