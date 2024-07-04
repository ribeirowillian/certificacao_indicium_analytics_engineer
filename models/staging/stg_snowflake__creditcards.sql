with
    source_creditcards as (
        select
            cast(creditcardid as int) as pk_creditcardid
            , cast(cardtype as string) as credticards_cardtype

        from {{ source("snowflake", "creditcard") }}

    )

select *
from source_creditcards
