import base64
import json
import os

from googleapiclient.discovery import build

LABELS = json.loads(os.environ["LABELS"])

compute = build("compute", "v1")


def main(event, context):

    if "data" not in event:
        print("No data found in event")
        return

    pubsub_message = base64.b64decode(
        event["data"]
    ).decode("utf-8")

    if not pubsub_message:
        print("Empty Pub/Sub message")
        return

    print(pubsub_message)

    message_json = json.loads(pubsub_message)

    asset = message_json.get("asset", {})

    asset_type = asset.get("assetType", "")

    if asset_type != "compute.googleapis.com/Instance":
        print("Not a compute instance event")
        return

    asset_name = asset.get("name", "")

    print(f"Asset Name: {asset_name}")

    parts = asset_name.split("/")

    if len(parts) < 9:
        print("Invalid asset name format")
        return

    project = parts[4]

    zone = parts[6]

    instance_name = parts[8]

    print(f"Project: {project}")
    print(f"Zone: {zone}")
    print(f"Instance: {instance_name}")

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

    print(f"Labels updated for {instance_name}")