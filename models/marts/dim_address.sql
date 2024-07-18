select 
    pk_addressid
    , address
    , city
    , postalcode
    , sp_name_stateprovince
    , name_country
from {{ ref("int_snowflake__address") }}
