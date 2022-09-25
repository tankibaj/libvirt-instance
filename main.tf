locals {
  name          = random_pet.this.id
  volume_size   = var.volume_size * 1073741824 # Convert Gibibyte to Byte
  pool_path     = "/var/lib/libvirt/pool/${random_pet.this.id}-${random_uuid.this.id}"
  ubunutu_image = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img"
}

resource "random_pet" "this" {}

resource "random_uuid" "this" {}

resource "libvirt_network" "this" {
  count     = var.network_name == "" ? 1 : 0
  name      = "${local.name}-${random_uuid.this.id}"
  domain    = "${local.name}.local"
  mode      = "nat"
  addresses = ["172.20.0.0/16"]
  autostart = true

  dhcp {
    enabled = true
  }

  dns {
    enabled = true
  }

}

resource "libvirt_pool" "this" {
  count = var.pool_name == "" ? 1 : 0
  name  = var.name == "" ? "${local.name}-${random_uuid.this.id}" : "${var.name}-${random_uuid.this.id}"
  type  = "dir"
  path  = var.pool_path == "" ? local.pool_path : var.pool_path
}

resource "libvirt_cloudinit_disk" "this" {
  count          = var.user_data == "" ? 0 : 1
  name           = var.name == "" ? "${local.name}-cloudinit.iso" : "${var.name}-cloudinit.iso"
  user_data      = var.user_data
  network_config = var.network_config
  pool           = var.pool_name == "" ? libvirt_pool.this[0].name : var.pool_name
}

resource "libvirt_volume" "base_volume" {
  count  = var.base_volume_id == "" ? 1 : 0
  name   = var.name == "" ? "${local.name}-base" : "${var.name}-base"
  pool   = var.pool_name == "" ? libvirt_pool.this[0].name : var.pool_name
  source = var.image_path == "" ? local.ubunutu_image : var.image_path
  format = "qcow2"
}

resource "libvirt_volume" "root_volume" {
  count          = var.root_volume_id == "" ? 1 : 0
  name           = var.name == "" ? "${local.name}-root" : "${var.name}-root"
  base_volume_id = var.base_volume_id == "" ? libvirt_volume.base_volume[0].id : var.base_volume_id
  pool           = var.pool_name == "" ? libvirt_pool.this[0].name : var.pool_name
  size           = local.volume_size
}

resource "libvirt_domain" "this" {
  name      = var.name == "" ? local.name : var.name
  memory    = var.memory
  vcpu      = var.vcpu
  autostart = var.autostart

  network_interface {
    network_name   = var.network_name == "" ? libvirt_network.this[0].name : var.network_name
    wait_for_lease = var.network_wait_for_lease
  }

  disk {
    volume_id = var.root_volume_id == "" ? libvirt_volume.root_volume[0].id : var.root_volume_id
  }

  cloudinit = var.user_data != "" ? libvirt_cloudinit_disk.this[0].id : null

  graphics {
    type           = var.graphics_type
    listen_type    = "address"
    listen_address = "0.0.0.0"
    autoport       = true
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }
  
  lifecycle {
    ignore_changes = [network_interface]
  }
}

