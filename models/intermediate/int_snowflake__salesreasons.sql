with
    salesorderheaders as (
        select
            pk_salesorderid,
            fk_customerid,
            fk_salespersonid,
            fk_territoryid,
            fk_creditcardid
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
            fk_customerid,
            fk_salespersonid,
            fk_territoryid,
            fk_creditcardid,
            sr.pk_salesreasonid,
            sr.reason_for_sale
        from salesorderheaders soh
        left join
            salesorderheadersalesreasons sohsr on soh.pk_salesorderid = sohsr.pk_salesorderid
        left join 
            salesreasons sr on sohsr.fk_salesreasonid = sr.pk_salesreasonid
    )
select *
from order_reasons
