WITH source_products AS (
    SELECT 
        CAST(productid AS INT) AS pk_product,
        CAST(productsubcategoryid AS INT) AS fk_productsubcategoryid,
        CAST(productmodelid AS VARCHAR) AS fk_productmodelid,
        CAST(name AS VARCHAR) AS name_product,
        CAST(color AS VARCHAR) AS color,
        CAST(size AS VARCHAR) AS sizes,
    FROM {{ source("snowflake", "product") }}
)

SELECT *
FROM source_products