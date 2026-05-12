from googleapiclient.discovery import build

sqladmin = build("sqladmin", "v1beta4")


def handle_cloud_sql(asset, LABELS):

    asset_name = asset.get("name", "")

    print(f"Cloud SQL Asset Name: {asset_name}")

    parts = asset_name.split("/")

    if len(parts) < 6:
        print("Invalid Cloud SQL asset format")
        return

    project = parts[4]

    instance_name = parts[5]

    print(f"Project: {project}")
    print(f"Instance: {instance_name}")

    instance = (
        sqladmin.instances()
        .get(
            project=project,
            instance=instance_name
        )
        .execute()
    )

    existing_labels = instance.get("settings", {}).get("userLabels", {})

    print(f"Existing Labels: {existing_labels}")

    merged_labels = {
        **existing_labels,
        **LABELS
    }

    print(f"Merged Labels: {merged_labels}")

    if existing_labels == merged_labels:

        print("Labels already present")

        return

    body = {
        "settings": {
            "userLabels": merged_labels
        }
    }

    operation = (
        sqladmin.instances()
        .patch(
            project=project,
            instance=instance_name,
            body=body
        )
        .execute()
    )

    print("Cloud SQL label update started")

    print(operation)