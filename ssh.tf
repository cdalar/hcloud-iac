variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

resource "hcloud_ssh_key" "default" {
  name       = "My SSH Key"
  public_key = file(var.ssh_public_key)
}
