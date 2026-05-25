# ☁️ Real-Time AWS & Snowflake Data Pipeline

An end-to-end, event-driven data engineering pipeline that automatically extracts real-time weather data, processes it through a serverless AWS architecture, and continuously loads it into a Snowflake data warehouse for analysis via a Streamlit dashboard.

## 🏗️ Architecture & Data Flow

This project implements a modern ELT (Extract, Load, Transform) pattern with zero manual intervention:

1. **Extraction:** An **Amazon EventBridge** schedule triggers a Python-based **AWS Lambda** function every 15 minutes.
2. **API Integration:** The Lambda function fetches live weather data for Kochi, India, from the **OpenWeather API**.
3. **NoSQL Storage & Landing:** Data is stored in **Amazon DynamoDB**, and a DynamoDB stream routes the records into an **Amazon S3** bucket (the landing zone).
4. **Automated Ingestion:** **Snowflake Snowpipe** is configured with SQS event notifications. Whenever a new JSON file hits S3, Snowpipe automatically wakes up and ingests the data immediately.
5. **Transformation & Visualization:** Snowflake SQL views unmarshal DynamoDB’s highly nested JSON format into structured relational tables, which are dynamically queried by a **Streamlit** Python dashboard.

## 🛠️ Tech Stack

* **Cloud Infrastructure:** AWS (Lambda, S3, DynamoDB, EventBridge, IAM)
* **Data Warehouse:** Snowflake (Snowpipe, External Stages, Storage Integrations)
* **Languages:** Python 3.x, SQL
* **Frontend:** Streamlit
* **Data Format:** Semi-structured JSON

## 📁 Repository Structure

```text
.
├── producerLambda.py       # Lambda: Fetches OpenWeather API data -> DynamoDB
├── consumerLambda.py       # Lambda: Processes DynamoDB streams to S3
├── snowflake.sql           # Infrastructure: Tables, S3 Stages, and Snowpipe logic
├── .gitignore              # Secures environment variables
└── README.md               # Project documentation
