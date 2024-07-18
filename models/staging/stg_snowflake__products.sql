WITH source_products AS (
    SELECT 
        CAST(productid AS INT) AS pk_productid
        , CAST(productsubcategoryid AS INT) AS productsubcategoryid
        , CAST(productmodelid AS INT) AS productmodelid
        , name AS name_product
        , CAST(color AS VARCHAR) AS color
        , size AS sizes
    FROM {{ source("snowflake", "product") }}
)

SELECT *
FROM source_products