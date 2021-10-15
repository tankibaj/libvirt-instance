resource "libvirt_network" "this" {
  name      = "vbridge"
  mode      = "bridge"
  bridge    = "br0"
  autostart = true
}

module "instance" {
  source = "../../"

  network_name = libvirt_network.this.name
}