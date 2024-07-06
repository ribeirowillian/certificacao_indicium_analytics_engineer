WITH products AS (
    SELECT 
        pk_product,
        subcategoryid_product,
        modelid_product,
        name_product,
        name_color,
        name_size
    FROM {{ ref('stg_snowflake__products') }}
),

productsubcategorys AS (
    SELECT
        pk_productsubcategoryid,
        fk_productcategoryid,
        productsubcategorys_name
    FROM {{ ref('stg_snowflake__productsubcategorys') }}
),

productcategorys AS (
    SELECT
        pk_productcategoryid,
        productcategory_name
    FROM {{ ref('stg_snowflake__productcategorys') }}
)

SELECT 
    sp.pk_product,
    sp.subcategoryid_product,
    sp.modelid_product,
    sp.name_product,
    sp.name_color,
    sp.name_size,
    spsc.productsubcategorys_name,
    spc.productcategory_name
FROM 
    products sp
LEFT JOIN 
    productsubcategorys spsc ON sp.subcategoryid_product = spsc.pk_productsubcategoryid
LEFT JOIN 
    productcategorys spc ON spsc.fk_productcategoryid = spc.pk_productcategoryid
