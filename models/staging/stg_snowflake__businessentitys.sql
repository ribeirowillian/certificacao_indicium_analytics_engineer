with
    source_businessentitys as (
        select cast(businessentityid as int) as pk_businessentityid
        from {{ source("snowflake", "businessentity") }}
    )
select *
from source_businessentitys
