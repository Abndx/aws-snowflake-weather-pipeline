-- ==========================================
-- STEP 3: Manual Load & Data Parsing
-- ==========================================
COPY INTO weather_raw
FROM @weather_stage
FILE_FORMAT = (TYPE = 'JSON');

SELECT 
    v:location::string as city,
    v:weather[0].M.description.S::string as description,
    TO_TIMESTAMP_NTZ(v:timestamp::int) as utc_observation_time,
    CONVERT_TIMEZONE('UTC', 'Asia/Kolkata', TO_TIMESTAMP_NTZ(v:timestamp::int)) as local_ist_time
FROM weather_raw 
ORDER BY local_ist_time;