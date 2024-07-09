with
    creditcards as (
        select
            PK_CREDITCARDID,
            CARDTYPE
        from {{ ref('stg_snowflake__creditcards') }}
    ),
    personcreditcards as (
        select
            PK_BUSINESSENTITYID,
            FK_CREDITCARDID
        from {{ ref('stg_snowflake__personcreditcards') }}
    )

select
    personcreditcards.pk_businessentityid,
    creditcards.pk_creditcardid,
    personcreditcards.fk_creditcardid,
    creditcards.CARDTYPE
from
    personcreditcards
left join
    creditcards
on
    personcreditcards.fk_creditcardid = creditcards.pk_creditcardid

