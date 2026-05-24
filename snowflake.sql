-- 1. Create Database and Schema
CREATE DATABASE IF NOT EXISTS weather_db;
CREATE SCHEMA IF NOT EXISTS weather_db.raw;

-- Tell this worksheet session to use them
USE DATABASE weather_db;
USE SCHEMA raw;

-- 2. Setup AWS Storage Integration
CREATE OR REPLACE STORAGE INTEGRATION s3_weather_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_ALLOWED_LOCATIONS = ('s3://weather-data-pipeline-landing-zone/raw-data/')
  STORAGE_AWS_ROLE_ARN = 'SNOWFLAKE_ROLE_ARN';

DESC INTEGRATION s3_weather_integration;


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
