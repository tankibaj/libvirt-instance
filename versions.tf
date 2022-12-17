terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}
