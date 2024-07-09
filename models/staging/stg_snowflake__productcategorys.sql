with
    source_productcategorys as (
        select
            cast(productcategoryid as int) as pk_productcategoryid
            , cast(name as varchar) as name_category

        from {{ source("snowflake", "productcategory") }}
    )

select *
from source_productcategorys
