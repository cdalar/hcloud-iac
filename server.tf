resource "hcloud_server" "master1" {
  name        = "master1"
  image       = "ubuntu-18.04"
  server_type = "cx11"
  ssh_keys    = [hcloud_ssh_key.default.id]
  location    = "fsn1"

}
resource "hcloud_server" "worker1" {
  name        = "worker1"
  image       = "ubuntu-18.04"
  server_type = "cx21"
  ssh_keys    = [hcloud_ssh_key.default.id]
  location    = "fsn1"
  labels = {
    "type" = "worker"
  }
}
resource "hcloud_server" "worker2" {
  name        = "worker2"
  image       = "ubuntu-18.04"
  server_type = "cx21"
  ssh_keys    = [hcloud_ssh_key.default.id]
  location    = "fsn1"
  labels = {
    "type" = "worker"
  }
}
resource "hcloud_server" "worker3" {
  name        = "worker3"
  image       = "ubuntu-18.04"
  server_type = "cx21"
  ssh_keys    = [hcloud_ssh_key.default.id]
  location    = "fsn1"
  labels = {
    "type" = "worker"
  }
}

output "server_ips" {
  value = map(
    "master1", hcloud_server.master1.ipv4_address,
    "worker1", hcloud_server.worker1.ipv4_address,
    "worker2", hcloud_server.worker2.ipv4_address,
    "worker3", hcloud_server.worker3.ipv4_address,
  )
}


resource "local_file" "ansible_inventory" {
  filename = "tf_hosts.yml"
  content  = <<EOF
hcloud:
  hosts:
    master1:
      ansible_host: ${hcloud_server.master1.ipv4_address}
      ansible_user: root
    worker1:
      ansible_host: ${hcloud_server.worker1.ipv4_address}
      ansible_user: root
    worker2:
      ansible_host: ${hcloud_server.worker2.ipv4_address}
      ansible_user: root
    worker3:
      ansible_host: ${hcloud_server.worker3.ipv4_address}
      ansible_user: root
EOF

}

resource "local_file" "etc-hosts" {
  filename = "tf_etc-hosts"
  content  = <<EOT
${hcloud_server.master1.ipv4_address} master1
${hcloud_server.worker1.ipv4_address} worker1
${hcloud_server.worker2.ipv4_address} worker2
${hcloud_server.worker3.ipv4_address} worker3
EOT

  provisioner "local-exec" {
    command    = "sudo sed -i '' '/${hcloud_server.master1.ipv4_address}/d;/${hcloud_server.worker1.ipv4_address}/d;/${hcloud_server.worker2.ipv4_address}/d;/${hcloud_server.worker3.ipv4_address}/d;' ~/.ssh/known_hosts"
    on_failure = continue
  }
  provisioner "local-exec" {
    command    = "sudo sed -i '' '/${hcloud_server.master1.ipv4_address}/d;/${hcloud_server.worker1.ipv4_address}/d;/${hcloud_server.worker2.ipv4_address}/d;/${hcloud_server.worker3.ipv4_address}/d;' /etc/hosts"
    on_failure = continue
  }
  provisioner "local-exec" {
    command    = "sudo sed -i '' '$r tf_etc-hosts' /etc/hosts"
    on_failure = continue
  }


}
