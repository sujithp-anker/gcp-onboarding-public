resource "null_resource" "vm_labels" {

  depends_on = [module.vm]

  for_each = toset(var.instance_names)

  provisioner "local-exec" {

    interpreter = ["/bin/bash", "-c"]

    command = <<EOT
export PATH=$PATH:/root/google-cloud-sdk/bin

gcloud compute instances add-labels ${each.value} \
--labels=managed_by=${var.labels["managed_by"]} \
--zone=${var.zone} \
--project=${var.project_id}
EOT
  }
}

resource "null_resource" "deletion_protection" {

  depends_on = [module.vm]

  for_each = var.enable_deletion_protection ? toset(var.instance_names) : []

  provisioner "local-exec" {

    interpreter = ["/bin/bash", "-c"]

    command = <<EOT
export PATH=$PATH:/root/google-cloud-sdk/bin

gcloud compute instances update ${each.value} \
--zone=${var.zone} \
--project=${var.project_id} \
--deletion-protection
EOT
  }
}