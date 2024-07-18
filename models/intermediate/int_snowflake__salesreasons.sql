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
                when sr.reason_for_sale = 'price' then 'preço'
                when sr.reason_for_sale = 'on promotion' then 'em promoção'
                when sr.reason_for_sale = 'magazine advertisement' then 'anúncio de revista'
                when sr.reason_for_sale = 'television advertisement' then 'anúncio de televisão'
                when sr.reason_for_sale = 'manufacturer' then 'fabricante'
                when sr.reason_for_sale = 'review' then 'análise'
                when sr.reason_for_sale = 'demo event' then 'evento de demonstração'
                when sr.reason_for_sale = 'sponsorship' then 'patrocínio'
                when sr.reason_for_sale = 'quality' then 'qualidade'
                when sr.reason_for_sale = 'other' then 'outro'
                else 'sem motivo'
            end as motivo_da_venda
        from salesorderheaders soh
        left join
            salesorderheadersalesreasons sohsr on soh.pk_salesorderid = sohsr.pk_salesorderid
        left join 
            salesreasons sr on sohsr.fk_salesreasonid = sr.pk_salesreasonid
    )
select *
from order_reasons
