import azure.functions as func
import logging
import os
from azure.storage.blob import BlobServiceClient, ContentSettings
from io import BytesIO
from PIL import Image

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    # Get the image from the request
    image = req.files.get('image')

    if image:
        # Process the image (resize, etc.) if necessary
        img = Image.open(BytesIO(image.read()))

        # Set up the Azure Storage client
        connection_string = os.environ['IMGS_STORAGE_CONNECTION_STRING']
        container_name = 'images'
        blob_service_client = BlobServiceClient.from_connection_string(connection_string)
        container_client = blob_service_client.get_container_client(container_name)

        # Save the image to Azure Storage
        blob_name = f'{image.filename}'
        blob_client = container_client.get_blob_client(blob_name)
        img_data = BytesIO()
        img.save(img_data, 'JPEG')
        img_data.seek(0)
        content_settings = ContentSettings(content_type='image/jpeg')
        blob_client.upload_blob(img_data, overwrite=True, content_settings=content_settings)

        return func.HttpResponse(f"Image '{image.filename}' uploaded successfully.")
    else:
        return func.HttpResponse(
            "Please provide an image in the 'image' field.",
            status_code=400
        )
