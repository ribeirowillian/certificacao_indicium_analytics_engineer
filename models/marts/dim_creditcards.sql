select 
    pk_businessentityid
    , fk_creditcardid
    , cardtype

from {{ ref("int_snowflake__creditcards") }}
