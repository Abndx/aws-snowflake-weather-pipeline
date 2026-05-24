-- ==========================================
-- STEP 4: The Automation Engine (Snowpipe)
-- ==========================================
CREATE OR REPLACE PIPE weather_db.raw.weather_pipe
AUTO_INGEST = TRUE
AS
COPY INTO weather_db.raw.weather_raw
FROM @weather_stage
FILE_FORMAT = (TYPE = 'JSON');

SHOW PIPES;
SELECT SYSTEM$PIPE_STATUS('weather_pipe');