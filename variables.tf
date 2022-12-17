variable "name" {
  description = "Name to be used on instance created"
}

variable "memory" {
  description = "The amount of memory in MiB. If not specified the domain will be created with 512 MiB of memory be used"
  type        = number
  default     = 512
}

variable "vcpu" {
  description = "The amount of virtual CPUs. If not specified, a single CPU will be created"
  type        = number
  default     = 1
}

variable "autostart" {
  description = "Whether instance will be auto started or not"
  default     = "true"
}

variable "network_name" {
  description = "Name of network to associate with instance"
  default     = ""
}

variable "network_wait_for_lease" {
  description = "Whether instance will be wait for the DHCP IP lease"
  default     = false
}

variable "graphics_type" {
  description = "Type of graphics emulation. spice | vnc"
  type        = string
  default     = "vnc"
}

variable "root_volume_id" {
  description = "ID of root volume if already exist"
  default     = ""
}

variable "base_volume_id" {
  description = "ID of base OS image if already exist"
  default     = ""
}

variable "image_path" {
  description = "OS image path/url to provision instance"
  default     = ""
}

variable "volume_size" {
  description = "The size of the volume in GB"
  type        = number
  default     = 5
}

variable "pool_name" {
  description = "Name of pool where all volumes will stored"
  default     = "default"
}

variable "pool_path" {
  description = "Path of pool where all volumes will stored"
  default     = ""
}

variable "user_data" {
  description = "Cloud-init user data"
  default     = ""
}

variable "network_config" {
  description = "Cloud-init network config"
  default     = ""
}
