WITH source_products AS (
    SELECT 
        CAST(productid AS INT) AS pk_product,
        CAST(productsubcategoryid AS VARCHAR) AS subcategoryid_product,
        CAST(productmodelid AS VARCHAR) AS modelid_product,
        CAST(name AS VARCHAR) AS name_product,
        CAST(color AS VARCHAR) AS name_color,
        CAST(size AS VARCHAR) AS name_size,
    FROM {{ source("snowflake", "product") }}
)

SELECT *
FROM source_products