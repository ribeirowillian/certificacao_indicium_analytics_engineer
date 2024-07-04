with 
    products as (
        select *
        from {{ ref('stg_snowflake__products') }}
    )

select * 
from products