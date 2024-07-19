with
    vendas_2011 as (
        select sum (DISCOUNTED_ITEM_TOTAL) as total_liquido
        from {{ ref('fct_sales') }}
        where OH_ORDERDATE between '2011-01-01' and '2011-12-31'
    )
select total_liquido 
from vendas_2011 
where total_liquido not between 12641664 and 12641665

-- valor da que a contabilidade encontrou em 2011  $12.646.112,16.

-- Valor encontrado com nosso modelo $12.641.664,53