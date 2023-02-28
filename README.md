# TencentCloud CVM Module for Terraform

## terraform-tencentcloud-cvm

A terraform module used for create TencentCloud CVM instance.

## Examples
- simple instance
```hcl
provider "tencentcloud" {
  region = "ap-hongkong"
}

data "tencentcloud_instance_types" "c2m2" {
  exclude_sold_out  = true
  cpu_core_count    = 2
  memory_size       = 2
  availability_zone = "ap-hongkong-1"
}

data "tencentcloud_images" "tencentos" {
  instance_type = data.tencentcloud_instance_types.c2m2.instance_types[0].instance_type
  os_name       = "tencentos"
}

module "cvm" {
  source            = "terraform-tencentcloud-modules/cvm/tencentcloud"
  availability_zone = "ap-hongkong-1"
  instance_type     = data.tencentcloud_instance_types.c2m2.instance_types[0].instance_type
  image_id          = data.tencentcloud_images.tencentos.images[0].image_id
  
  allocate_public_ip = true
}
```

## Inputs

| Name                       | Description                                                                                                                                                                                                                                                                      | Type              | Default          | Required |
|----------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|------------------|:--------:|
| project_id                 | project id.                                                                                                                                                                                                                                                                      | number            | 0                |    no    |
| number_of_instances        | the number of instances to create.                                                                                                                                                                                                                                               | number            | 1                |    no    |
| instance_name              | the name of instance to create.                                                                                                                                                                                                                                                  | string            | cvm              |    no    |
| availability_zone          | The available zone for the instance.                                                                                                                                                                                                                                             | string            | null             |   yes    |
| image_id                   | The image to use for the instance. Changing image_id will cause the instance reset.                                                                                                                                                                                              | string            | null             |   yes    |
| instance_type              | instance type of instance.                                                                                                                                                                                                                                                       | string            | ""               |   yes    |
| system_disk_type           | System disk type. For more information on limits of system disk types, see Storage Overview. Valid values: LOCAL_BASIC: local disk, LOCAL_SSD: local SSD disk, CLOUD_SSD: SSD, CLOUD_PREMIUM: Premium Cloud                                                                      | string            | CLOUD_PREMIUM    |    no    |
| system_disk_size           | Size of the system disk. unit is GB, Default is 50GB. If modified, the instance may force stop.                                                                                                                                                                                  | number            | 50               |    no    |
| allocate_public_ip         | Associate a public IP address with an instance in a VPC or Classic. Boolean value, Default is false.                                                                                                                                                                             | bool              | false            |    no    |
| vpc_id                     | The ID of a VPC network. If you want to create instances in a VPC network, this parameter must be set or the default vpc will be used.                                                                                                                                           | string            | null             |    no    |
| subnet_id                  | The ID of a VPC subnet. If you want to create instances in a VPC network, this parameter must be set or the default subnet will be used.                                                                                                                                         | string            | null             |    no    |
| internet_max_bandwidth_out | Maximum outgoing bandwidth to the public network, measured in Mbps (Mega bits per second). This value does not need to be set when allocate_public_ip is false.                                                                                                                  | number            | 10               |    no    |
| key_ids                    | Key ids of the Key Pair to use for the instance; which can be managed using the `tencentcloud_key_pair` resource                                                                                                                                                                 | list(string)      | null             |    no    |
| password                   | Login password of the instance. For Linux instances, the password must include 8-30 characters, and contain at least two of the following character sets: [a-z], [A-Z], [0-9] and [()`~!@#$%^&*-+=                                                                               | string            | null             |    no    |
| security_group_ids         | A list of orderly security group IDs to associate with.                                                                                                                                                                                                                          | list(string)      | null             |    no    |
| private_ip                 | Private IP to associate with instances in a VPC, private IP must be an IP within the subnet specified by subnet_id.                                                                                                                                                              | list(string)      | []               |    no    |
| monitoring                 | If true, the launched EC2 instance will have detailed monitoring enabled                                                                                                                                                                                                         | bool              | true             |    no    |
| user_data_raw              | The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead.                                                                                                                                          | string            | null             |    no    |
| user_data_base64           | Can be used instead of user_data_raw to pass base64-encoded binary data directly. Use this instead of user_data_raw whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption. | string            | null             |    no    |
| cam_role_name              | CAM role name authorized to access.                                                                                                                                                                                                                                              | string            | null             |    no    |
| instance_charge_type       | TencentCloud International only supports POSTPAID_BY_HOUR and CDHPAID.  CDHPAID instance must set cdh_instance_type and cdh_host_id.                                                                                                                                             | string            | POSTPAID_BY_HOUR |    no    |
| cdh_instance_type          | Type of instance created on cdh, the value of this parameter is in the format of CDH_XCXG based on the number of CPU cores and memory capacity. Note: it only works when instance_charge_type is set to CDHPAID.                                                                 | string            | null             |    no    |
| cdh_host_id                | Id of cdh instance. Note: it only works when instance_charge_type is set to CDHPAID.                                                                                                                                                                                             | string            | null             |    no    |
| placement_group_id         | The Placement Group Id to start the instance in, see tencentcloud_placement_group.                                                                                                                                                                                               | string            | ""               |    no    |
| placement_group_name       | The Placement group name to start the instance in, see tencentcloud_placement_group. will ignore if placement_group_id passed.                                                                                                                                                   | string            | ""               |    no    |
| placement_group_type       | The Placement Group type to start the instance in, see tencentcloud_placement_group. will ignore if placement_group_id passed.                                                                                                                                                   | string            | HOST             |    no    |
| cbs_block_devices          | Additional CBS block devices to attach to the instance. see resource tencentcloud_cbs_storage.                                                                                                                                                                                   | list(map(string)) | []               |    no    |
| cbs_block_device_ids       | Attach exist CBS block devices to the instance by id.  see resource tencentcloud_cbs_storage.                                                                                                                                                                                    | list(string)      | []               |    no    |
| cbs_tags                   | Additional tags to assign to cbs resource.                                                                                                                                                                                                                                       | map(string)       | {}               |    no    |
| eni_ids                    | A list of eni_id to bind with the instance. see resource tencentcloud_eni.                                                                                                                                                                                                       | list(string)      | []               |    no    |
| tags                       | A mapping of tags to assign to the resource.                                                                                                                                                                                                                                     | map(string)       | {}               |    no    |


## Outputs

| Name                | Description                                     |
|---------------------|-------------------------------------------------|
| instance_id         | the ids of instances                            |
| instance_status     | the states of instances                         |
| public_ip           | the public ips of instances                     |
| private_ip          | the private ips of instances                    |
| placement_group_id  | The Placement group id to start the instance in |

## License

Mozilla Public License Version 2.0.
See LICENSE for full details.
