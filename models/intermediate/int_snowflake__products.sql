with 
    source_products as (
        select 
            pk_productid
            , productsubcategoryid as fk_productsubcategoryid
            , productmodelid as fk_productmodelid
            , name_product
            , color
            , sizes
        from {{ ref('stg_snowflake__products') }}
    ),

    source_product_subcategorys as (
        select
            pk_productsubcategoryid
            , productcategoryid as fk_productcategoryid
            , name_subcategory
        from {{ ref('stg_snowflake__productsubcategorys') }}
    ),

    source_product_categorys as (
        select
            pk_productcategoryid
            , name_category
        from {{ ref('stg_snowflake__productcategorys') }}
    )

select
    sp.pk_productid
    , sp.fk_productsubcategoryid
    , sp.fk_productmodelid
    , sp.name_product
    , sp.color
    , sp.sizes
    , spsc.name_subcategory
    , spc.name_category
from source_products sp
left join
    source_product_subcategorys spsc on sp.fk_productsubcategoryid = spsc.pk_productsubcategoryid
left join 
    source_product_categorys spc on spsc.fk_productcategoryid = spc.pk_productcategoryid
