output "function_name" {

  value = google_cloudfunctions2_function.labeler_function.name
}

output "pubsub_topic" {

  value = google_pubsub_topic.asset_events.name
}