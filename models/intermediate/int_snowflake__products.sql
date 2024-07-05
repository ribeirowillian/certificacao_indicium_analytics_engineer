with products as (
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
extracted_numbers as (
    select
        *,
        regexp_substr(name_clean_intermediate, '\\d+$') as extracted_size,
        regexp_replace(name_clean_intermediate, ' \\d+$', '') as name_clean_final
    from products
)
select
    pk_product,
    modelid_product,
    name_product,
    coalesce(extracted_size, name_size) as name_size,
    name_color,
    name_clean_final as name_clean_intermediate
from extracted_numbers
