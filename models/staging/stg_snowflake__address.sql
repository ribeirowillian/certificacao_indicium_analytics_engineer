with
    source_address as (
        select
            cast(addressid as int) as addressid
            , cast(stateprovinceid as int) as stateprovinceid
            , addressline1 as address
            , city
            , postalcode
        from {{ source("snowflake", "address") }}
    )
select *
from source_address
