resource "libvirt_network" "this" {
  name      = "k8s-cluster"
  mode      = "bridge"
  bridge    = "br0"
  autostart = true
}

module "instance" {
  source = "../../"

  count          = 2
  name           = "k8s-node${count.index + 1}"
  memory         = 1024
  vcpu           = 1
  volume_size    = 10
  image_path     = "/home/naim/workspace/cloud-images/focal-server-cloudimg-amd64.img"
  network_name   = libvirt_network.this.name
  user_data      = templatefile("${path.module}/user-data.yaml", { HOST_NAME = "k8s-node${count.index + 1}", USERNAME = "naim", PASSWORD = "123123" })
  network_config = templatefile("${path.module}/network-config.yaml", { IP_ADDRESS = "192.168.1.20${count.index + 1}/24", GATEWAY = "192.168.1.1" })
}