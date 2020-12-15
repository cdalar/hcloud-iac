# Set the variable value in *.tfvars file
# or using the -var="hcloud_token=..." CLI option
variable "hcloud_token" {}

# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = var.hcloud_token
}

resource "local_file" "tf_hcloud_token" {
    filename = "tf_hcloud_token"
    content     = var.hcloud_token
}

