select
    pk_cliente
    , cd_cliente
    , cd_loja
    , cd_pessoa
    , cd_vendedor_atribuido
    , tp_cliente
    , nm_vendedor_atribuido
    , nm_cliente
from {{ ref("int_snowflake__clients") }}
