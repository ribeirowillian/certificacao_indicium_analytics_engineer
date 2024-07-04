with
    products as (
        select
            pk_product,
            modelid_product,
            name_product,
            name_size,
            name_color,
            -- Criando uma nova coluna com o nome limpo sem o tamanho e sem a cor.
            case
                when name_color is not null and name_size is not null
                then
                    regexp_replace(
                        regexp_replace(name_product, concat(' ', name_color), ''),
                        concat(', ', name_size),
                        ''
                    )
                when name_color is not null
                then regexp_replace(name_product, concat(' ', name_color), '')
                when name_size is not null
                then regexp_replace(name_product, concat(', ', name_size), '')
                else name_product
            end as name_clean_intermediate
        from {{ ref('stg_snowflake__products') }}
    ),
    cleaned_products as (
        select
            pk_product,
            modelid_product,
            name_product,
            name_size,
            name_color,
            -- Removendo '-' ou ',' ao final de cada palavra na coluna name_clean_intermediate
            regexp_replace(
                regexp_replace(
                    regexp_replace(name_clean_intermediate, '-$', ''),
                    ',$', ''
                ),
                '-,', ' '
            ) as name_clean
        from products
    )

select *
from cleaned_products
