with
    salesorderheaders as (
        select
            pk_salesorderid
            , customerid as fk_customerid
            , salespersonid as fk_salespersonid
        from {{ ref("stg_snowflake__salesorderheaders") }}
    ),
    salesreasons as (
        select 
            pk_salesreasonid
            , reason_for_sale
        from {{ ref("stg_snowflake__salesreasons") }}
    ),
    salesorderheadersalesreasons as (
        select 
            pk_salesorderid
            , fk_salesreasonid
        from {{ ref("stg_snowflake__salesorderheadersalesreasons") }}
    ),
    order_reasons as (
        select
            soh.pk_salesorderid
            , soh.fk_customerid
            , soh.fk_salespersonid
            , sr.pk_salesreasonid
            , case
                when sr.reason_for_sale = 'Price' then 'Preço'
                when sr.reason_for_sale = 'On Promotion' then 'Em promoção'
                when sr.reason_for_sale = 'Magazine Advertisement' then 'Anúncio de revista'
                when sr.reason_for_sale = 'Television Advertisement' then 'Anúncio de televisão'
                when sr.reason_for_sale = 'Manufacturer' then 'Fabricante'
                when sr.reason_for_sale = 'Review' then 'Análise'
                when sr.reason_for_sale = 'Demo Event' then 'Evento de demonstração'
                when sr.reason_for_sale = 'Sponsorship' then 'Patrocínio'
                when sr.reason_for_sale = 'Quality' then 'Qualidade'
                when sr.reason_for_sale = 'Other' then 'Outro'
                else 'Sem motivo' 
            end as motivo_da_venda
        from salesorderheaders soh
        left join
            salesorderheadersalesreasons sohsr on soh.pk_salesorderid = sohsr.pk_salesorderid
        left join 
            salesreasons sr on sohsr.fk_salesreasonid = sr.pk_salesreasonid
    )
select *
from order_reasons
