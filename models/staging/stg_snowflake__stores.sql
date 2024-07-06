with
    source_stores as (
        select *
            -- cast(addressid as int) as pk_addressid
            -- , cast(stateprovinceid as int) as fk_stateprovinceid
            -- , cast(addressline1 as varchar) as address_addressline1
            -- , cast(city as varchar) as address_city
            -- , cast(postalcode as varchar) as address_postalcode

        from {{ source("snowflake", "store") }}

    )

select *
from source_stores
