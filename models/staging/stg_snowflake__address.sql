with
    source_address as (
        select
            cast(addressid as int) as address_id
            , cast(stateprovinceid as int) as stateprovince_id
            , addressline1 as address
            , city
            , postalcode

        from {{ source("snowflake", "address") }}

    )

select *
from source_address
