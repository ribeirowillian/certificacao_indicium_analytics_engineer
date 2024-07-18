with
    source_productcategorys as (
        select
            cast(productcategoryid as int) as pk_productcategoryid
            , name as name_category

        from {{ source("snowflake", "productcategory") }}
    )

select *
from source_productcategorys
