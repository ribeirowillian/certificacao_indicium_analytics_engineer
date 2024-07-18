select
    pk_productid
    , fk_productsubcategoryid
    , fk_productmodelid
    , name_product
    , color
    , sizes
    , name_subcategory
    , name_category
from {{ ref("int_snowflake__products") }}
