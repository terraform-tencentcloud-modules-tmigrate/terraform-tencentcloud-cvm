
resource "tencentcloud_instance" "instance" {
  count = var.number_of_instances

  instance_name     = var.number_of_instances > 1 ? "${var.instance_name}-${count.index}" : var.instance_name
  availability_zone = var.availability_zone
  image_id          = var.image_id
  instance_type     = var.instance_type

  system_disk_type = var.system_disk_type
  system_disk_size = var.system_disk_size

  project_id                 = var.project_id
  allocate_public_ip         = var.allocate_public_ip
  internet_max_bandwidth_out = var.internet_max_bandwidth_out
  vpc_id                     = var.vpc_id
  subnet_id                  = var.subnet_id
  private_ip                 = length(var.private_ip) > count.index ? var.private_ip[count.index] : null

  key_ids                 = var.key_ids
  orderly_security_groups = var.security_group_ids
  disable_monitor_service = !var.monitoring
  user_data_raw           = var.user_data_raw
  user_data               = var.user_data_base64
  cam_role_name           = var.cam_role_name

  instance_charge_type = var.instance_charge_type
  cdh_instance_type    = var.cdh_instance_type
  cdh_host_id          = var.cdh_host_id

  placement_group_id = var.placement_group_id

  data_disks {
    data_disk_type = var.data_disk_type
    data_disk_size = var.data_disk_size
    encrypt        = var.data_disk_encryption
  }

  tags = var.tags
}
