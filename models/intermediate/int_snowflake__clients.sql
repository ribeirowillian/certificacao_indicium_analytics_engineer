WITH businessentity AS (
    SELECT
        PK_BUSINESSENTITYID
    FROM {{ ref('stg_snowflake__businessentitys') }}
),

customers AS (
    SELECT
        PK_CUSTOMERID,
        FK_TERRITORYID,
        FK_PERSONID
    FROM {{ ref('stg_snowflake__customers') }}
),

persons AS (
    SELECT
        PK_BUSINESSENTITYID,
        PERSON_PERSONTYPE,
        PERSON_FULLNAME,
        PERSON_EMAILPROMOTION
    FROM {{ ref('stg_snowflake__persons') }}
),

stores AS (
    SELECT
        PK_BUSINESSENTITYID,
        FK_SALESPERSONID,
        NAME_STORE
    FROM {{ ref('stg_snowflake__stores') }}
),

-- Criando a visão de clientes individuais (pessoas físicas)
cliente_pessoa AS (
    SELECT
        customers.PK_CUSTOMERID,
        0 AS STOREID,    
        customers.FK_PERSONID AS PERSONID,
        'Individual' AS TP_CLIENTE,
        persons.PERSON_FULLNAME AS NM_CLIENTE,
        0 AS CD_VENDEDOR_ATRIBUIDO,
        'Venda feita pelo cliente' AS NM_VENDEDOR_ATRIBUIDO
    FROM customers
    INNER JOIN persons
    ON customers.FK_PERSONID = persons.PK_BUSINESSENTITYID
    WHERE customers.FK_PERSONID IS NOT NULL
),

-- Criando a visão de clientes empresariais (lojas)
cliente_loja AS (
    SELECT
        customers.PK_CUSTOMERID,
        stores.PK_BUSINESSENTITYID AS STOREID,
        0 AS PERSONID,
        'Empresarial (loja)' AS TP_CLIENTE,
        stores.NAME_STORE AS NM_CLIENTE,
        COALESCE(stores.FK_SALESPERSONID, 0) AS CD_VENDEDOR_ATRIBUIDO,
        CASE
            WHEN stores.FK_SALESPERSONID IS NULL THEN 'Venda feita pelo cliente'
            ELSE stores.FK_SALESPERSONID::TEXT  -- Substitua por uma junção para obter o nome do vendedor, se disponível
        END AS NM_VENDEDOR_ATRIBUIDO
    FROM customers
    INNER JOIN stores
    ON customers.FK_PERSONID IS NULL
    AND customers.PK_CUSTOMERID = stores.PK_BUSINESSENTITYID
),

-- Unindo as tabelas de clientes
uniao_tabelas AS (
    SELECT *
    FROM cliente_pessoa
    UNION ALL
    SELECT *
    FROM cliente_loja
),

-- Calculando chaves e selecionando colunas
chaves AS (
    SELECT
        HASH(PK_CUSTOMERID) AS PK_CLIENTE,
        PK_CUSTOMERID AS CD_CLIENTE,
        STOREID AS CD_LOJA,
        PERSONID AS CD_PESSOA,
        CD_VENDEDOR_ATRIBUIDO,
        TP_CLIENTE,
        NM_VENDEDOR_ATRIBUIDO,
        NM_CLIENTE
    FROM uniao_tabelas
)

SELECT *
FROM chaves
