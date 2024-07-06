with
    creditcards as (
        select
            pk_creditcardid,
            credticards_cardtype
        from {{ ref('stg_snowflake__creditcards') }}
    ),
    personcreditcards as (
        select
            pk_businessentityid,
            fk_creditcardid
        from {{ ref('stg_snowflake__personcreditcards') }}
    )

select
    personcreditcards.pk_businessentityid,
    creditcards.pk_creditcardid,
    personcreditcards.fk_creditcardid,
    creditcards.credticards_cardtype
from
    personcreditcards
left join
    creditcards
on
    personcreditcards.fk_creditcardid = creditcards.pk_creditcardid
