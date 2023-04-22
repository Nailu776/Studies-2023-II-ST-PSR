import os
import json
import azure.functions as func
from azure.storage.blob import BlobServiceClient, ContainerClient, BlobClient
from azure.data.tables import TableClient

def get_desc(name: str, dict: dict) -> str:
    sanitized_blob_name = name.replace("/", "_")
    result = next((item for item in dict if item["name"] == sanitized_blob_name), 'Brak')
    if(result == 'Brak'):
        return result
    else:
        return result["description"]

def main(req: func.HttpRequest) -> func.HttpResponse:
    try:
        IMAGES_CONNECTION_STRING = os.environ["IMGS_STORAGE_CONNECTION_STRING"]
        DESC_CONNECTION_STRING = os.environ["DESC_STORAGE_CONNECTION_STRING"]
        DESC_STORAGE_TABLE_NAME = os.environ["DESC_STORAGE_TABLE_NAME"] 
        CONTAINER_NAME = "images"

        blob_service_client = BlobServiceClient.from_connection_string(IMAGES_CONNECTION_STRING)
        container_client = blob_service_client.get_container_client(CONTAINER_NAME)

        # Get Descriptions
        my_filter = "PartitionKey eq 'descriptions'"
        table_client = TableClient.from_connection_string(conn_str=DESC_CONNECTION_STRING, 
                                                        table_name=DESC_STORAGE_TABLE_NAME)
        entities = table_client.query_entities(my_filter)
        descriptions_list = []
        for entity in entities:
            descriptions_list.append({
                'name' : entity['RowKey'],
                'description' : entity['Description']
            })
        print(descriptions_list)
        image_list = []
        for blob in container_client.list_blobs():
            if blob.content_settings.content_type.startswith('image/'):
                image_list.append({
                    'name': blob.name,
                    'url': f"{container_client.url}/{blob.name}",
                    'description' : get_desc(blob.name, descriptions_list)
                })

        return func.HttpResponse(json.dumps(image_list), status_code=200, mimetype="application/json")
    except Exception as e:
        return func.HttpResponse(str(e), status_code=500)
