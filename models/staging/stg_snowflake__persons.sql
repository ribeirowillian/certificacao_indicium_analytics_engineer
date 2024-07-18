with
    source_persons as (
        select
            cast(businessentityid as int) as pk_businessentityid
            , persontype
            , trim(
                coalesce(firstname, '')
                || case when middlename is not null then ' ' || middlename else '' end
                || case when lastname is not null then ' ' || lastname else '' end
            ) as person_fullname
            , emailpromotion
        from {{ source("snowflake", "person") }}
    )
select *
from source_persons
