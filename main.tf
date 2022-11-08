provider "tencentcloud" {
  region = var.region
}


resource "tencentcloud_instance" "instance" {
  count = var.number_of_instances

  instance_name     = var.instance_name
  availability_zone = var.availability_zone
  image_id          = var.image_id
  instance_type     = var.instance_type
  system_disk_type  = var.system_disk_type
  system_disk_size  = var.system_disk_size
  project_id        = var.project_id
  vpc_id            = var.vpc_id
  subnet_id         = var.subnet_id
  key_name          = var.key_name
  security_groups   = var.security_groups

  data_disks {
    data_disk_type = var.data_disk_type
    data_disk_size = var.data_disk_size
    encrypt        = var.data_disk_encryption
  }

  tags = var.instance_tags
}
