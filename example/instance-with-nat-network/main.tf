resource "libvirt_network" "this" {
  name      = "internal"
  domain    = "internal.local"
  mode      = "nat"
  addresses = ["10.0.100.0/24"]

  dhcp {
    enabled = true
  }

  dns {
    enabled = true
  }

  autostart = true

}

module "instance" {
  source = "../../"

  network_name = libvirt_network.this.name
}