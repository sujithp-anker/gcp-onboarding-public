variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "function_name" {
  type = string
}

variable "pubsub_topic_name" {
  type = string
}

variable "asset_feed_name" {
  type = string
}

variable "labels_to_apply" {
  type = map(string)
}