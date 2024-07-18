with
    source_personcreditcards as (
        select
            cast(businessentityid as int) as pk_businessentityid,
            cast(creditcardid as int) as creditcardid

        from {{ source("snowflake", "personcreditcard") }}
    )
select *
from source_personcreditcards
