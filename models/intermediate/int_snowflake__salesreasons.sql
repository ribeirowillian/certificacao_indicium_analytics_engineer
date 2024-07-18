with
    salesorderheaders as (
        select
            pk_salesorderid,
            customerid as fk_customerid,
            salespersonid as fk_salespersonid
        from {{ ref("stg_snowflake__salesorderheaders") }}
    ),
    salesreasons as (
        select 
            pk_salesreasonid,
            reason_for_sale
        from {{ ref("stg_snowflake__salesreasons") }}
    ),
    salesorderheadersalesreasons as (
        select 
            pk_salesorderid,
            fk_salesreasonid
        from {{ ref("stg_snowflake__salesorderheadersalesreasons") }}
    ),
    order_reasons as (
        select
            soh.pk_salesorderid,
            soh.fk_customerid,
            soh.fk_salespersonid,
            sr.pk_salesreasonid,
            CASE
                WHEN sr.reason_for_sale = 'Price' THEN 'preço'
                WHEN sr.reason_for_sale = 'On Promotion' THEN 'em promoção'
                WHEN sr.reason_for_sale = 'Magazine Advertisement' THEN 'anúncio de revista'
                WHEN sr.reason_for_sale = 'Television Advertisement' THEN 'anúncio de televisão'
                WHEN sr.reason_for_sale = 'Manufacturer' THEN 'fabricante'
                WHEN sr.reason_for_sale = 'Review' THEN 'análise'
                WHEN sr.reason_for_sale = 'Demo Event' THEN 'evento de demonstração'
                WHEN sr.reason_for_sale = 'Sponsorship' THEN 'patrocínio'
                WHEN sr.reason_for_sale = 'Quality' THEN 'qualidade'
                WHEN sr.reason_for_sale = 'Other' THEN 'outro'
                ELSE 'Sem motivo'
            END as motivo_da_venda
        from salesorderheaders soh
        left join
            salesorderheadersalesreasons sohsr on soh.pk_salesorderid = sohsr.pk_salesorderid
        left join 
            salesreasons sr on sohsr.fk_salesreasonid = sr.pk_salesreasonid
    )
select *
from order_reasons
