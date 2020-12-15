variable "ip_range" {
  default = "10.10.0.0/16"
}

resource "hcloud_network" "k8s-net" {
  name     = "k8s-net"
  ip_range = var.ip_range
}

resource "hcloud_network_subnet" "k8s-subnet" {
  network_id   = hcloud_network.k8s-net.id
  type         = "server"
  network_zone = "eu-central"
  ip_range     = var.ip_range
}

resource "hcloud_server_network" "master1" {
  server_id  = hcloud_server.master1.id
  network_id = hcloud_network.k8s-net.id
  ip         = "10.10.0.10"
}
resource "hcloud_server_network" "worker1" {
  server_id  = hcloud_server.worker1.id
  network_id = hcloud_network.k8s-net.id
  ip         = "10.10.0.11"
}
resource "hcloud_server_network" "worker2" {
  server_id  = hcloud_server.worker2.id
  network_id = hcloud_network.k8s-net.id
  ip         = "10.10.0.12"
}
resource "hcloud_server_network" "worker3" {
  server_id  = hcloud_server.worker3.id
  network_id = hcloud_network.k8s-net.id
  ip         = "10.10.0.13"
}

resource "local_file" "hcloud_network_id" {
  filename = "tf_hcloud_network_id"
  content  = hcloud_network.k8s-net.id
}
