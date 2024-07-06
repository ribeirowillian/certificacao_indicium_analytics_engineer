with
    source_productsubcategorys as (
        select
            cast(productsubcategoryid as int) as pk_productsubcategoryid
            , cast(productcategoryid as int) as fk_productcategoryid
            , cast(name as varchar) as productsubcategorys_name

        from {{ source("snowflake", "productsubcategory") }}
    )

select *
from source_productsubcategorys
