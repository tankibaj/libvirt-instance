Terraform module to provision a libvirt instance.



## Usage

**Simple Instnace**

```hcl
module "instance" {
  source = "../../"

}
```



**Single Instance**

```hcl
resource "libvirt_network" "this" {
  name      = "my-network"
  mode      = "bridge"
  bridge    = "br0"
  autostart = true
}

module "instance" {
  source = "../../"

  name           = "my-instance"
  memory         = 512
  vcpu           = 1
  volume_size    = 8
  network_name   = libvirt_network.this.name
}
```



**Multiple  Instance**

```hcl
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
  image_path     = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img"
  network_name   = libvirt_network.this.name
}
```




## Requirements

| Name | Version |
|------|---------|
| [libvirt](https://github.com/dmacvicar/terraform-provider-libvirt) | 0.6.11 |
| [terraform](https://www.terraform.io/downloads.html) | 0.15+ |

<br>

## Provider

| Name | Version |
|------|---------|
| [libvirt](https://github.com/dmacvicar/terraform-provider-libvirt) | 0.6.11 |

<br>

## Resources

| Name | Type |
|------|------|
| [libvirt_cloudinit_disk.this](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/cloudinit) | resource |
| [libvirt_domain.this](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/domain) | resource |
| [libvirt_network.this](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/network) | resource |
| [libvirt_pool.this](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/pool) | resource |
| [libvirt_volume.base_volume](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/volume) | resource |
| [libvirt_volume.root_volume](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/volume) | resource |
| [random_pet.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [random_uuid.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |

<br>

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autostart"></a> [autostart](#input\_autostart) | Whether instance will be auto started or not | `string` | `"true"` | no |
| <a name="input_base_volume_id"></a> [base\_volume\_id](#input\_base\_volume\_id) | ID of base OS image if already exist | `string` | `""` | no |
| <a name="input_graphics_type"></a> [graphics\_type](#input\_graphics\_type) | Type of graphics emulation. spice \| vnc | `string` | `"vnc"` | no |
| <a name="input_image_path"></a> [image\_path](#input\_image\_path) | OS image path/url to provision instance | `string` | `""` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | The amount of memory in MiB. If not specified the domain will be created with 512 MiB of memory be used | `number` | `512` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be used on EC2 instance created | `string` | `""` | no |
| <a name="input_network_config"></a> [network\_config](#input\_network\_config) | Cloud-init network config | `string` | `""` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Name of network to associate with instance | `string` | `""` | no |
| <a name="input_network_wait_for_lease"></a> [network\_wait\_for\_lease](#input\_network\_wait\_for\_lease) | Whether instance will be wait for the DHCP IP lease | `bool` | `false` | no |
| <a name="input_pool_name"></a> [pool\_name](#input\_pool\_name) | Name of pool where all volumes will stored | `string` | `""` | no |
| <a name="input_pool_path"></a> [pool\_path](#input\_pool\_path) | Path of pool where all volumes will stored | `string` | `""` | no |
| <a name="input_root_volume_id"></a> [root\_volume\_id](#input\_root\_volume\_id) | ID of root volume if already exist | `string` | `""` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Cloud-init user data | `string` | `""` | no |
| <a name="input_vcpu"></a> [vcpu](#input\_vcpu) | The amount of virtual CPUs. If not specified, a single CPU will be created | `number` | `1` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | The size of the volume in GB | `number` | `5` | no |

<br>

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | Instance name |

