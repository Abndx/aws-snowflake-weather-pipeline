import json
import boto3
import urllib3
import time
from decimal import Decimal # Add this import

# Initialize DynamoDB
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('WeatherData')
http = urllib3.PoolManager()

def lambda_handler(event, context):
    api_key = "API_KEY"
    city = "Kochi" 
    url = f"https://api.openweathermap.org/data/2.5/weather?q={city}&appid={api_key}"
    
    try:
        # Fetch data
        response = http.request('GET', url)
        
        # Load JSON and convert all floats to Decimals for DynamoDB
        data = json.loads(response.data.decode('utf-8'), parse_float=Decimal)
        
        # Add your keys (as Strings to match your table schema)
        data['timestamp'] = str(int(time.time()))
        data['location'] = city
        
        # Save to DynamoDB
        table.put_item(Item=data)
        
        return {
            'statusCode': 200,
            'body': json.dumps(f"Weather data for {city} saved successfully!")
        }
    except Exception as e:
        # This will now print the specific error if it fails again
        print(f"Error occurred: {e}")
        return {
            'statusCode': 500,
            'body': json.dumps(f"Error: {str(e)}")
        }