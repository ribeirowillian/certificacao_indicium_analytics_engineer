with
    products as (
        select
            pk_product
            , modelid_product
            , name_clean_intermediate
            , name_product
            , name_size
            , name_color

        from {{ ref("int_snowflake__products") }}
    )

select *
from products
