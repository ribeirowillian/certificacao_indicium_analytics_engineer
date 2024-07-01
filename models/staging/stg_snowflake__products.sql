with
    source_products as (
        select
            cast(productid as int) as pk_product
            , cast(productsubcategoryid as varchar) as subcategoryid_product
            , cast(productmodelid as varchar) as modelid_product
            , cast(name as varchar) as name_product
            , cast(productnumber as varchar) as number_product
            , cast(standardcost as varchar) as satandarcost_product
            , cast(listprice as varchar) as listprice_product
            , cast(productline as varchar) as line_product
            , cast(class as varchar) as class_product
            
        from {{ source("snowflake", "product") }}

    )

select *
from
    source_products
  
