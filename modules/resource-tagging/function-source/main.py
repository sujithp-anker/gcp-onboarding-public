import base64
import json
import os

from handlers.compute import handle_compute_instance
from handlers.bucket import handle_bucket
from handlers.cloudrun import handle_cloud_run
from handlers.cloudfunction import handle_cloud_function
from handlers.disk import handle_disk
from handlers.cloudrunjob import handle_cloud_run_job

LABELS = json.loads(os.environ["LABELS"])


def main(event, context):

    try:

        if "data" not in event:
            print("No data found in event")
            return

        pubsub_message = base64.b64decode(
            event["data"]
        ).decode("utf-8")

        if not pubsub_message.strip():
            print("Empty Pub/Sub message")
            return

        print("RAW MESSAGE:")
        print(pubsub_message)

        message_json = json.loads(pubsub_message)

        asset = message_json.get("asset", {})

        asset_type = asset.get("assetType", "")

        print(f"Asset Type: {asset_type}")

        print(repr(asset_type))

        if asset_type == "compute.googleapis.com/Instance":

            handle_compute_instance(asset, LABELS)

        elif asset_type == "storage.googleapis.com/Bucket":

            handle_bucket(asset, LABELS)

        elif asset_type == "compute.googleapis.com/Disk":

            handle_disk(asset, LABELS)

        elif asset_type == "run.googleapis.com/Service":

            handle_cloud_run(asset, LABELS)

        elif "cloudfunction" in asset_type.lower():

            print("Cloud Function detected")

            handle_cloud_function(asset, LABELS)

        elif asset_type == "run.googleapis.com/Job":

            handle_cloud_run_job(asset, LABELS)    

        else:

            print("Unsupported asset type")
 "run.googleapis.com/Job"
    except Exception as e:

        print(f"ERROR: {str(e)}")

        raise