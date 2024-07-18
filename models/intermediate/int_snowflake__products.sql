WITH 
    source_products AS (
        SELECT 
            pk_productid
            , productsubcategoryid as fk_productsubcategoryid
            , productmodelid as fk_productmodelid
            , name_product
            , color
            , sizes
        FROM {{ ref('stg_snowflake__products') }}
    ),

    source_product_subcategorys AS (
        SELECT
            pk_productsubcategoryid
            , productcategoryid as fk_productcategoryid
            , name_subcategory
        FROM {{ ref('stg_snowflake__productsubcategorys') }}
    ),

    source_product_categorys AS (
        SELECT
            pk_productcategoryid
            , name_category
        FROM {{ ref('stg_snowflake__productcategorys') }}
    )


SELECT
    sp.pk_productid
    , sp.fk_productsubcategoryid
    , sp.fk_productmodelid
    , sp.name_product
    , sp.color
    , sp.sizes
    , spsc.name_subcategory
    , spc.name_category
FROM source_products sp
LEFT JOIN
    source_product_subcategorys spsc ON sp.fk_productsubcategoryid = spsc.pk_productsubcategoryid
LEFT JOIN 
    source_product_categorys spc ON spsc.fk_productcategoryid = spc.pk_productcategoryid

