-- ==========================================
-- STEP 2: The Landing Zone
-- ==========================================
CREATE OR REPLACE TABLE weather_raw (
    v variant
);

CREATE OR REPLACE STAGE weather_stage
  URL = 's3://weather-data-pipeline-landing-zone/raw-data/'
  STORAGE_INTEGRATION = s3_weather_integration;

LIST @weather_stage;
