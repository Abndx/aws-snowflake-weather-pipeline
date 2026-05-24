-- 5. Manual load for testing
COPY INTO weather_raw
FROM @weather_stage
FILE_FORMAT = (TYPE = 'JSON');

-- 6. Parse nested JSON and convert timestamps
SELECT 
    v:location::string as city,
    v:weather[0].M.description.S::string as description,
    -- This converts the Unix timestamp inside your JSON to a readable format
    TO_TIMESTAMP_NTZ(v:timestamp::int) as utc_observation_time,
    -- This converts that timestamp to your local IST time
    CONVERT_TIMEZONE('UTC', 'Asia/Kolkata', TO_TIMESTAMP_NTZ(v:timestamp::int)) as local_ist_time
FROM weather_raw 
ORDER BY local_ist_time;
