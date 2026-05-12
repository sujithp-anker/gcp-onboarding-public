
variable "Customer_Name" {
  type        = string
  description = "The name of the client (e.g., 'AcmeCorp'). Used to name all new resources."
}

variable "Project_Id" {
  type        = string
  description = "Project ID of the customer account."
}

variable "Region" { 
  type        = string
  default     = ""
  description = "The GCP Region where the servers and databases are located."
}

variable "Environment" {
  type        = string
  default     = "Stage"
  description = "Set to 'Prod' (30-day retention) or 'Stage' (7-day retention). Applies "
}

variable "Enable_Monitoring" {
  type        = bool
  default     = true
  description = "Turn OFF (false) to stop alerts and emails."
}

variable "Alert_Emails" {
  type        = string
  default     = ""
  description = "Comma-separated list of emails (e.g., 'admin@co.com,devops@co.com')."
}

variable "Enable_Snapshot_Schedule" {
  type        = bool
  default     = false
  description = "If true, enables automated daily snapshots for VM disks. Retention will be set based on Environment."
}

variable "Enable_IAM_Policy_Change_Alerts" {
  type    = bool
  default = false
  description = "Alert policy for IAM policy modification"
}

variable "Enable_Firewall_Events_Alerts" {
  type    = bool
  default = false
  description = "Alert policy for modifying firewall"
}

variable "Enable_Instance_Delete_Alerts" {
  type    = bool
  default = false
  description = "Alert policy for instance deletion"
}

variable "Enable_Instance_Insert_Alerts" {
  type    = bool
  default = false
  description = "Alert policy for instance creation"
}

variable "Enable_Label_Modification_Alerts" {
  type    = bool
  default = false
  description = "Alert policy for label modification"
}

variable "Enable_Service_Account_Creation_Alerts" {
  type    = bool
  default = false
  description = "Alert policy for service account creation"
}

variable "Enable_Disk_Deletion_Alerts" {
  type    = bool
  default = false
  description = "Alert policy for disk deletion"
}

variable "Enable_Service_Account_Key_Deletion_Alerts" {
  type    = bool
  default = false
  description = "Alert policy for service account key deletion"
}

variable "Enable_VM_Utilization_Alerts" {
  type        = bool
  default     = false
  description = "Enables CPU, Memory, and Disk alerts for VMs labeled with 'monitoring=true'."
}

variable "Enable_CloudSQL_Utilization_Alerts" {
  type        = bool
  default     = false
  description = "Enables CPU, Memory, Disk, Connections, and Lag alerts for Cloud SQL instances labeled with 'monitoring=true'."
}

variable "Enable_LB_Monitoring" {
  type        = bool
  default     = false
  description = "If true, enables 4xx and 5xx error rate monitoring for the Load Balancers listed."
}

variable "LB_Names_to_Monitor" {
  type        = string
  default     = ""
  description = "Comma-separated list of LB names."
}
variable "Enable_GKE_Utilization_Alerts" {
  type        = bool
  default     = false
  description = "Enables all GKE performance and health alerts for clusters labeled with 'monitoring=true'."
}

variable "Enable_GKE_Backup_Governance" {
  type        = bool
  default     = false
  description = "If true, sets up the GKE Backup Plan infrastructure. Clusters labeled 'backup=true' will be targeted."
}

variable "GKE_Cluster_ID" {
  type        = string
  default     = ""
  description = "Comma-separated list of full GKE Cluster IDs."
}

variable "Enable_Budget_Alerts" {
  type        = bool
  default     = false
}

variable "Billing_Account_ID" {
  type        = string
  description = "The GCP Billing Account ID."
}

variable "SET_BudgetLimit" {
  type        = string
  default     = ""
  description = "Monthly spending limit in USD (e.g., 500)."
}

variable "SET_BudgetActualThresholds" {
  type        = string
  default     = "50,75,100"
  description = "Alert when spending reaches these percentages (e.g., 50, 75, 100)."
}

variable "EnableResourceTagging" {
  description = "If true, deploys the CloudFormation stack for auto-tagging CreatedBy and CreatedAt."
  type        = bool
  default     = false
}