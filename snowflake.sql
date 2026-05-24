-- 3. Create a table for the raw JSON
CREATE OR REPLACE TABLE weather_raw (
    v variant
);

-- 4. Create the Stage pointing to S3
CREATE OR REPLACE STAGE weather_stage
  URL = 's3://weather-data-pipeline-landing-zone/raw-data/'
  STORAGE_INTEGRATION = s3_weather_integration;

-- Check if Snowflake can see your files
LIST @weather_stage;

