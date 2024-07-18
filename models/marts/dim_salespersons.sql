select 
    pk_businessentityid
    , territoryid as fk_territoryid 
from {{ ref("stg_snowflake__salespersons") }}
