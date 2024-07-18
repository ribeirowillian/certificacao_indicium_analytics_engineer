with
    businessentity as (
        select 
            pk_businessentityid 
        from {{ ref("stg_snowflake__businessentitys") }}
    ),

    customers as (
        select 
            pk_customerid
            , territory_id as fk_territoryid
            , person_id as fk_personid
        from {{ ref("stg_snowflake__customers") }}
    ),

    persons as (
        select 
            pk_businessentityid
            , persontype
            , person_fullname
        from {{ ref("stg_snowflake__persons") }}
    ),

    stores as (
        select 
            pk_businessentityid
            , salespersonid as fk_salespersonid
            , name_store
        from {{ ref("stg_snowflake__stores") }}
    ),

    -- Criando a visão de clientes individuais (pessoas físicas)
    cliente_pessoa as (
        select
            customers.pk_customerid
            , 0 as storeid
            , customers.fk_personid as personid
            , 'Individual' as tp_cliente
            , persons.person_fullname as nm_cliente
            , 0 as cd_vendedor_atribuido
            , 'Venda feita pelo cliente' as nm_vendedor_atribuido
        from customers
        inner join persons on customers.fk_personid = persons.pk_businessentityid
        where customers.fk_personid is not null
    ),

    -- Criando a visão de clientes empresariais (lojas)
    cliente_loja as (
        select
            customers.pk_customerid
            , stores.pk_businessentityid as storeid
            , 0 as personid
            , 'Empresarial (loja)' as tp_cliente
            , stores.name_store as nm_cliente
            , coalesce(stores.fk_salespersonid, 0) as cd_vendedor_atribuido
            , case
                when stores.fk_salespersonid is null
                then 'Venda feita pelo cliente'
                else stores.fk_salespersonid::text  -- Substitua por uma junção para obter o nome do vendedor, se disponível
            end as nm_vendedor_atribuido
        from customers
        inner join
            stores
            on customers.fk_personid is null
            and customers.pk_customerid = stores.pk_businessentityid
    ),

    -- Unindo as tabelas de clientes
    uniao_tabelas as (
        select *
        from cliente_pessoa
        union all
        select *
        from cliente_loja
    ),

    -- Calculando chaves e selecionando colunas
    chaves as (
        select
            hash(pk_customerid) as pk_cliente
            , pk_customerid as cd_cliente
            , storeid as cd_loja
            , personid as cd_pessoa
            , cd_vendedor_atribuido
            , tp_cliente
            , nm_vendedor_atribuido
            , nm_cliente
        from uniao_tabelas
    )

select *
from chaves
