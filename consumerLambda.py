import json
import boto3
import os

s3 = boto3.client('s3')
BUCKET_NAME = 'weather-data-pipeline-landing-zone'

def lambda_handler(event, context):
    for record in event['Records']:
        if record['eventName'] == 'INSERT':
            # 1. Extract the new data from the stream
            new_data = record['dynamodb']['NewImage']
            
            # 2. Simple transformation: Convert DynamoDB format to standard JSON
            # This is a helper to clean up the 'S' and 'N' tags from DynamoDB
            clean_data = {k: list(v.values())[0] for k, v in new_data.items()}
            
            # 3. Define the filename (using timestamp for uniqueness)
            file_name = f"weather_{clean_data['location']}_{clean_data['timestamp']}.json"
            
            # 4. Upload to S3
            s3.put_object(
                Bucket=BUCKET_NAME,
                Key=f"raw-data/{file_name}",
                Body=json.dumps(clean_data)
            )
            
    return {'statusCode': 200, 'body': 'Data transferred to S3'}
