WITH
    source_persons AS (
        SELECT 
            CAST(businessentityid AS INT) AS pk_businessentityid,
            CAST(persontype AS VARCHAR) AS person_persontype,
            TRIM(
                COALESCE(CAST(firstname AS VARCHAR), '') || 
                CASE WHEN middlename IS NOT NULL THEN ' ' || CAST(middlename AS VARCHAR) ELSE '' END || 
                CASE WHEN lastname IS NOT NULL THEN ' ' || CAST(lastname AS VARCHAR) ELSE '' END
            ) AS person_fullname,
            CAST(emailpromotion AS VARCHAR) AS person_emailpromotion,
            CAST(modifieddate AS VARCHAR) AS person_modifieddate
        FROM {{ source("snowflake", "person") }}
    )
SELECT *
FROM source_persons
