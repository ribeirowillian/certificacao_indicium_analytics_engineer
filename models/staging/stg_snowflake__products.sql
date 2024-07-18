with
    source_products as (
        select
            cast(productid as int) as pk_productid
            , cast(productsubcategoryid as int) as productsubcategoryid
            , cast(productmodelid as int) as productmodelid
            , name as name_product
            , cast(color as varchar) as color
            , size as sizes
        from {{ source("snowflake", "product") }}
    )
select *
from source_products
