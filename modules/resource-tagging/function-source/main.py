import base64
import json
import os

from googleapiclient.discovery import build

LABELS = json.loads(os.environ["LABELS"])

compute = build("compute", "v1")
functions = build("cloudfunctions", "v2")


def handle_compute_instance(asset):

    asset_name = asset.get("name", "")

    parts = asset_name.split("/")

    project = parts[4]
    zone = parts[6]
    instance_name = parts[8]

    print(f"VM Project: {project}")
    print(f"VM Zone: {zone}")
    print(f"VM Instance: {instance_name}")

    instance = compute.instances().get(
        project=project,
        zone=zone,
        instance=instance_name
    ).execute()

    existing_labels = instance.get("labels", {})

    merged_labels = {
        **existing_labels,
        **LABELS
    }

    compute.instances().setLabels(
        project=project,
        zone=zone,
        instance=instance_name,
        body={
            "labels": merged_labels,
            "labelFingerprint": instance["labelFingerprint"]
        }
    ).execute()

    print(f"VM labels updated for {instance_name}")


def handle_cloud_function(asset):

    asset_name = asset.get("name", "")

    print(f"Function Asset Name: {asset_name}")

    function = functions.projects().locations().functions().get(
        name=asset_name
    ).execute()

    existing_labels = function.get("labels", {})

    merged_labels = {
        **existing_labels,
        **LABELS
    }

    function["labels"] = merged_labels

    update_request = functions.projects().locations().functions().patch(
        name=asset_name,
        updateMask="labels",
        body=function
    )

    update_request.execute()

    print(f"Cloud Function labels updated")


def main(event, context):

    try:

        if "data" not in event:
            print("No data found")
            return

        pubsub_message = base64.b64decode(
            event["data"]
        ).decode("utf-8")

        message_json = json.loads(pubsub_message)

        asset = message_json.get("asset", {})

        asset_type = asset.get("assetType", "")

        print(f"Asset Type: {asset_type}")

        if asset_type == "compute.googleapis.com/Instance":

            handle_compute_instance(asset)

        elif asset_type == "cloudfunctions.googleapis.com/Function":

            handle_cloud_function(asset)

        else:

            print("Unsupported asset type")

    except Exception as e:

        print(f"ERROR: {str(e)}")

        raise