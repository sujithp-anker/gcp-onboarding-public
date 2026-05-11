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
# Pub/Sub Topic
# ----------------------------------------

resource "google_pubsub_topic" "asset_events" {
  name = var.pubsub_topic_name
}

# ----------------------------------------
# Cloud Asset Feed
# ----------------------------------------

resource "google_cloud_asset_organization_feed" "asset_feed" {

  provider = google-beta

  organization = var.organization_id

  feed_id = var.asset_feed_name

  content_type = "RESOURCE"

  asset_types = [
    "compute.googleapis.com/Instance",
    "compute.googleapis.com/Disk",
    "storage.googleapis.com/Bucket"
  ]

  feed_output_config {

    pubsub_destination {

      topic = google_pubsub_topic.asset_events.id
    }
  }

  depends_on = [
    google_project_service.services
  ]
}

# ----------------------------------------
# Service Account
# ----------------------------------------

resource "google_service_account" "labeler_sa" {

  account_id   = "event-driven-labeler"
  display_name = "Event Driven Labeler"
}

# ----------------------------------------
# IAM Permissions
# ----------------------------------------

resource "google_project_iam_member" "compute_admin" {

  project = var.project_id
  role    = "roles/compute.admin"

  member = "serviceAccount:${google_service_account.labeler_sa.email}"
}

resource "google_project_iam_member" "storage_admin" {

  project = var.project_id
  role    = "roles/storage.admin"

  member = "serviceAccount:${google_service_account.labeler_sa.email}"
}

# ----------------------------------------
# Function Source ZIP
# ----------------------------------------

data "archive_file" "function_zip" {

  type = "zip"

  source_dir  = "${path.module}/function-source"
  output_path = "${path.module}/function-source.zip"
}

# ----------------------------------------
# Function Bucket
# ----------------------------------------

resource "google_storage_bucket" "function_bucket" {

  name     = "${var.project_id}-resource-tagging-function"
  location = var.region

  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "function_archive" {

  name   = "function-source.zip"
  bucket = google_storage_bucket.function_bucket.name

  source = data.archive_file.function_zip.output_path
}

# ----------------------------------------
# Cloud Function Gen2
# ----------------------------------------

resource "google_cloudfunctions2_function" "labeler_function" {

  name     = var.function_name
  location = var.region

  build_config {

    runtime     = "python311"
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