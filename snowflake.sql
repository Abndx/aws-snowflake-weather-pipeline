-- 7. Create Snowpipe for automated ingestion
CREATE OR REPLACE PIPE weather_db.raw.weather_pipe
AUTO_INGEST = TRUE
AS
COPY INTO weather_db.raw.weather_raw
FROM @weather_stage
FILE_FORMAT = (TYPE = 'JSON');


-- 8. Pipe Monitoring and Troubleshooting Commands
SHOW PIPES;

SELECT SYSTEM$PIPE_STATUS('weather_pipe');

-- SELECT * FROM TABLE(INFORMATION_SCHEMA.PIPE_USAGE_HISTORY(
--     DATE_RANGE_START=>DATEADD('hour',-1,CURRENT_TIMESTAMP()),
--     PIPE_NAME=>'weather_pipe'));

-- ALTER PIPE weather_pipe REFRESH;
