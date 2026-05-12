resource "google_project_service" "services" {

  for_each = toset([
    "cloudfunctions.googleapis.com",
    "cloudasset.googleapis.com",
    "pubsub.googleapis.com",
    "cloudbuild.googleapis.com",
    "artifactregistry.googleapis.com",
    "eventarc.googleapis.com",
    "run.googleapis.com"
  ])

  project = var.project_id

  service = each.value

  disable_on_destroy = false
}

# ----------------------------------------
# Current Project Info
# ----------------------------------------

data "google_project" "current" {

  project_id = var.project_id
}

# ----------------------------------------
# Pub/Sub Topic
# ----------------------------------------

resource "google_pubsub_topic" "asset_events" {

  name = var.pubsub_topic_name
}

# ----------------------------------------
# Allow Cloud Asset API To Publish
# ----------------------------------------

resource "google_pubsub_topic_iam_member" "asset_feed_publisher" {

  project = var.project_id

  topic = google_pubsub_topic.asset_events.name

  role = "roles/pubsub.publisher"

  member = "serviceAccount:service-${data.google_project.current.number}@gcp-sa-cloudasset.iam.gserviceaccount.com"
}

# ----------------------------------------
# Project Asset Feed
# ----------------------------------------

resource "google_cloud_asset_project_feed" "asset_feed" {

  project = var.project_id

  feed_id = var.asset_feed_name

  content_type = "RESOURCE"

  asset_types = [
    "compute.googleapis.com/Instance",
    "compute.googleapis.com/Disk",
    "storage.googleapis.com/Bucket",
    "cloudfunctions.googleapis.com/Function",
    "run.googleapis.com/Service",
    "run.googleapis.com/Job"
  ]

  feed_output_config {

    pubsub_destination {

      topic = google_pubsub_topic.asset_events.id
    }
  }

  depends_on = [
    google_project_service.services,
    google_pubsub_topic_iam_member.asset_feed_publisher
  ]
}

# ----------------------------------------
# Service Account
# ----------------------------------------

resource "google_service_account" "labeler_sa" {

  account_id = "event-driven-labeler"

  display_name = "Event Driven Labeler"
}

# ----------------------------------------
# IAM Permissions
# ----------------------------------------

resource "google_project_iam_member" "compute_admin" {

  project = var.project_id

  role = "roles/compute.admin"

  member = "serviceAccount:${google_service_account.labeler_sa.email}"
}

resource "google_project_iam_member" "storage_admin" {

  project = var.project_id

  role = "roles/storage.admin"

  member = "serviceAccount:${google_service_account.labeler_sa.email}"
}

resource "google_project_iam_member" "cloudfunctions_admin" {

  project = var.project_id

  role = "roles/cloudfunctions.admin"

  member = "serviceAccount:${google_service_account.labeler_sa.email}"
}

resource "google_project_iam_member" "run_admin" {

  project = var.project_id

  role = "roles/run.admin"

  member = "serviceAccount:${google_service_account.labeler_sa.email}"
}

resource "google_project_iam_member" "cloudsql_admin" {

  project = var.project_id

  role = "roles/cloudsql.admin"

  member = "serviceAccount:${google_service_account.labeler_sa.email}"
}

resource "google_project_iam_member" "container_admin" {

  project = var.project_id

  role = "roles/container.admin"

  member = "serviceAccount:${google_service_account.labeler_sa.email}"
}

# ----------------------------------------
# Random Bucket Suffix
# ----------------------------------------

resource "random_id" "bucket_suffix" {

  byte_length = 4
}

# ----------------------------------------
# Archive Function Code
# ----------------------------------------

data "archive_file" "function_zip" {

  type = "zip"

  source_dir = "${path.module}/function-source"

  output_path = "${path.module}/function-source.zip"
}

# ----------------------------------------
# Storage Bucket
# ----------------------------------------

resource "google_storage_bucket" "function_bucket" {

  name = "${var.project_id}-resource-tagging-${random_id.bucket_suffix.hex}"

  location = var.region

  uniform_bucket_level_access = true
}

# ----------------------------------------
# Upload ZIP
# ----------------------------------------

resource "google_storage_bucket_object" "function_archive" {

  name = "function-source-${data.archive_file.function_zip.output_md5}.zip"

  bucket = google_storage_bucket.function_bucket.name

  source = data.archive_file.function_zip.output_path
}

# ----------------------------------------
# Cloud Function Gen2
# ----------------------------------------

resource "google_cloudfunctions2_function" "labeler_function" {

  name = var.function_name

  location = var.region

  build_config {

    runtime = "python311"

    entry_point = "main"

    source {

      storage_source {

        bucket = google_storage_bucket.function_bucket.name

        object = google_storage_bucket_object.function_archive.name
      }
    }
  }

  service_config {

    max_instance_count = 1

    available_memory = "256M"

    timeout_seconds = 60

    service_account_email = google_service_account.labeler_sa.email

    environment_variables = {

      LABELS = jsonencode(var.labels_to_apply)
    }
  }

  event_trigger {

    trigger_region = var.region

    event_type = "google.cloud.pubsub.topic.v1.messagePublished"

    pubsub_topic = google_pubsub_topic.asset_events.id

    retry_policy = "RETRY_POLICY_RETRY"
  }
}

resource "google_service_account_iam_member" "cloudrun_actas" {

  service_account_id = "projects/${var.project_id}/serviceAccounts/${data.google_project.current.number}-compute@developer.gserviceaccount.com"

  role = "roles/iam.serviceAccountUser"

  member = "serviceAccount:${google_service_account.labeler_sa.email}"
}