module "agent_policy" {
  source  = "terraform-google-modules/cloud-operations/google//modules/agent-policy"
  version = "~> 0.2.3"

  project_id = var.project_id

  policy_id = "ops-agent-policy"

  agent_rules = [
    {
      type               = "ops-agent"
      version            = "current-major"
      package_state      = "installed"
      enable_autoupgrade = true
    }
  ]

  group_labels = [
    {
      env = "prod"
    }
  ]

  os_types = [
    {
      short_name = "ubuntu"
      version    = "22.04"
    }
  ]
}