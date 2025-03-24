{{
    config(
        materialized='table',
        partition_by={"field": "heart_attack", "data_type": "boolean"},
        cluster_by=["gender", "region", "hypertension", "diabetes"]
    )
}}

SELECT * FROM {{ ref('cleaned_data') }}
