with
    source_address as (
        select
            cast(addressid as int) as pk_addressid
            , cast(stateprovinceid as int) as fk_stateprovinceid
            , cast(addressline1 as varchar) as address
            , cast(city as varchar) as city
            , cast(postalcode as varchar) as postalcode

        from {{ source("snowflake", "address") }}

    )

select *
from source_address
