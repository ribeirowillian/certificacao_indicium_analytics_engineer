with
    source_persons as (
        select
            cast(businessentityid as int) as pk_businessentityid
            , cast(persontype as varchar) as person_persontype
            , cast(firstname as varchar) as person_firstname
            , cast(middlename as varchar) as person_middlename
            , cast(lastname as varchar) as person_lastname
            , cast(emailpromotion as varchar) as person_emailpromotion
            , cast(modifieddate as varchar) as person_modifieddate

        from {{ source("snowflake", "person") }}

    )

select *
from source_persons
