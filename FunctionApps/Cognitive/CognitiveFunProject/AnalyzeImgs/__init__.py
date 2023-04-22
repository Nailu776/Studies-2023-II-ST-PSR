import logging
import azure.functions as func
from azure.cognitiveservices.vision.computervision import ComputerVisionClient
from azure.cognitiveservices.vision.computervision.models import VisualFeatureTypes
from msrest.authentication import CognitiveServicesCredentials
from azure.data.tables import TableClient, TableEntity, TableServiceClient
from azure.core.exceptions import ResourceExistsError
import json
import os

def main(myblob: func.InputStream) -> None:

    logging.info(f"Python blob trigger function processed blob \n"

                 f"Name: {myblob.name}\n"

                 f"Blob Size: {myblob.length} bytes")

    # Set up the Computer Vision client
    COGNITIVE_SERVICES_KEY = os.environ["COGNITIVE_SERVICES_KEY"]
    COGNITIVE_SERVICES_ENDPOINT = os.environ["COGNITIVE_SERVICES_ENDPOINT"]

    credentials = CognitiveServicesCredentials(COGNITIVE_SERVICES_KEY)
    client = ComputerVisionClient(COGNITIVE_SERVICES_ENDPOINT, credentials)

    # Analyze the image
    features = [VisualFeatureTypes.description]
    result = client.analyze_image_in_stream(myblob, features)

    # Extract the description
    if len(result.description.captions) > 0:
        description = result.description.captions[0].text
        logging.info(f"Image description: {description}")

        # DONE: Save the description associated with the image
        # Set up the Table Storage client
        DESC_STORAGE_CONNECTION_STRING = os.environ["DESC_STORAGE_CONNECTION_STRING"]
        DESC_STORAGE_TABLE_NAME = os.environ["DESC_STORAGE_TABLE_NAME"] 

        table_service_client = TableServiceClient.from_connection_string(conn_str=DESC_STORAGE_CONNECTION_STRING)

        # Check if the table exists, create it if not
        try:
            logging.info(f"Trying to get table: {DESC_STORAGE_TABLE_NAME}")
            table_client = table_service_client.get_table_client(table_name=DESC_STORAGE_TABLE_NAME)
        except:
            # Check if the table exists, create it if not
            try:
                logging.info(f"Create table: {DESC_STORAGE_TABLE_NAME}")
                # table_client.create_table()
            except ResourceExistsError:
                pass  # Table already exists, continue execution

        # Create the table entity
        # Ignore images/ -> first 7 chars (container name in storage acc)
        sanitized_blob_name = myblob.name[7:].replace("/", "_")
        # my_entity = {
        #     u'PartitionKey': "descriptions",
        #     u'RowKey': sanitized_blob_name,
        #     u'Description': description,
        # }
        # entity = table_client.create_entity(entity=my_entity)
        entity = TableEntity(PartitionKey="descriptions", RowKey=sanitized_blob_name, Description=description)
        try:
            # Insert the entity into the table
            table_client.create_entity(entity)
        except ResourceExistsError:
            logging.info(f"Entity already exists. Ignoring the entity with RowKey: {sanitized_blob_name}")

        logging.info(f"Entity finished: {myblob.name}")
    else:
        logging.warning("No description found for the image")

