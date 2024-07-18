select
    pk_salesorderid
    , pk_salesreasonid
    , fk_customerid
    , fk_salespersonid
    , motivo_da_venda
from {{ ref("int_snowflake__salesreasons") }}
