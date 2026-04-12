variable "days_in_cycle" {
    type = number
  description = "Takes the snapshot on every mentioned days"
}

variable "start_time" {
    type = number
  description = "Mention the time to start the schedule"
}

variable "retention_days" {
    type = number
  description = "Mention the retension days to store the snapshots"
}