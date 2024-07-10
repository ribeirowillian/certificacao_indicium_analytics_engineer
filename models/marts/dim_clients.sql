select
    PK_CLIENTE,
    CD_CLIENTE,
    CD_LOJA,
    CD_PESSOA,
    CD_VENDEDOR_ATRIBUIDO,
    TP_CLIENTE,
    NM_VENDEDOR_ATRIBUIDO,
    NM_CLIENTE
FROM {{ ref('int_snowflake__clients') }}