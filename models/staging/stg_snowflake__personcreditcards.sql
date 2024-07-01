with
    source_personcreditcards as (
        select
            cast(businessentityid as int) as fk_businessentityid,
            cast(creditcardid as int) as fk_creditcardid

        from {{ source("snowflake", "personcreditcard") }}

    )

select *
from source_personcreditcards
