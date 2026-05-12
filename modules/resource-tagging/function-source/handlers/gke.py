from googleapiclient.discovery import build

container = build("container", "v1")


def handle_gke_cluster(asset, LABELS):

    asset_name = asset.get("name", "")

    print(f"GKE Cluster Asset Name: {asset_name}")

    parts = asset_name.split("/")

    if len(parts) < 8:
        print("Invalid GKE cluster asset format")
        return

    project = parts[4]

    region_or_zone = parts[6]

    cluster_name = parts[7]

    print(f"Project: {project}")
    print(f"Location: {region_or_zone}")
    print(f"Cluster: {cluster_name}")

    cluster = (
        container.projects()
        .locations()
        .clusters()
        .get(
            name=f"projects/{project}/locations/{region_or_zone}/clusters/{cluster_name}"
        )
        .execute()
    )

    existing_labels = cluster.get("resourceLabels", {})

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
        "resourceLabels": merged_labels,
        "labelFingerprint": cluster["labelFingerprint"]
    }

    operation = (
        container.projects()
        .locations()
        .clusters()
        .resourceLabels(
            projectId=project,
            zone=region_or_zone,
            clusterId=cluster_name,
            body=body
        )
        .execute()
    )

    print("GKE labels update started")

    print(operation)