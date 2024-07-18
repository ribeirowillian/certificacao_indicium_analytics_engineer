with
    source_productsubcategorys as (
        select
            cast(productsubcategoryid as int) as pk_productsubcategoryid
            , cast(productcategoryid as int) as productcategoryid
            , name as name_subcategory

        from {{ source("snowflake", "productsubcategory") }}
    )

select *
from source_productsubcategorys
