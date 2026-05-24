-- ==========================================
-- STEP 1: Foundation & Security
-- ==========================================
CREATE DATABASE IF NOT EXISTS weather_db;
CREATE SCHEMA IF NOT EXISTS weather_db.raw;

USE DATABASE weather_db;
USE SCHEMA raw;

CREATE OR REPLACE STORAGE INTEGRATION s3_weather_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_ALLOWED_LOCATIONS = ('s3://weather-data-pipeline-landing-zone/raw-data/')
  STORAGE_AWS_ROLE_ARN = 'SNOWFLAKE_ROLE_ARN';

DESC INTEGRATION s3_weather_integration;
