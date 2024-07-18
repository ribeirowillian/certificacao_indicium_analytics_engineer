WITH
    source_persons AS (
        SELECT 
            CAST(businessentityid AS INT) AS pk_businessentityid
            , persontype
            , TRIM(
                COALESCE(firstname, '') || 
                CASE WHEN middlename IS NOT NULL THEN ' ' || middlename ELSE '' END || 
                CASE WHEN lastname IS NOT NULL THEN ' ' || lastname ELSE '' END
            ) AS person_fullname
            , emailpromotion
        FROM {{ source("snowflake", "person") }}
    )
SELECT *
FROM source_persons
