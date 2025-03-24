{{
    config(
        materialized='view'
    )
}}

SELECT
    -- Standardize categorical columns (convert to lowercase)
    LOWER(`gender`) AS gender,
    LOWER(`region`) AS region,
    LOWER(`income_level`) AS income_level,
    LOWER(`smoking_status`) AS smoking_status,
    LOWER(`alcohol_consumption`) AS alcohol_consumption,
    LOWER(`physical_activity`) AS physical_activity,
    LOWER(`dietary_habits`) AS dietary_habits,
    LOWER(`air_pollution_exposure`) AS air_pollution_exposure,
    LOWER(`stress_level`) AS stress_level,
    LOWER(`EKG_results`) AS ekg_results,  -- Fixed column casing

    -- Convert binary categorical columns to Boolean
    CAST(`hypertension` AS BOOLEAN) AS hypertension,
    CAST(`diabetes` AS BOOLEAN) AS diabetes,
    CAST(`obesity` AS BOOLEAN) AS obesity,
    CAST(`family_history` AS BOOLEAN) AS family_history,
    CAST(`previous_heart_disease` AS BOOLEAN) AS previous_heart_disease,
    CAST(`medication_usage` AS BOOLEAN) AS medication_usage,
    CAST(`participated_in_free_screening` AS BOOLEAN) AS participated_in_free_screening,
    CAST(`heart_attack` AS BOOLEAN) AS heart_attack,

    -- Keep numerical columns unchanged
    `age`,
    `cholesterol_level`,
    `waist_circumference`,
    `sleep_hours`,
    `blood_pressure_systolic`,
    `blood_pressure_diastolic`,
    `fasting_blood_sugar`,
    `cholesterol_hdl`,
    `cholesterol_ldl`,
    `triglycerides`

FROM {{ source('heart_attack_source', 'heart_attack_data') }}
