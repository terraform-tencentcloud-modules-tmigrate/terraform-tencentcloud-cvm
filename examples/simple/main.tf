data "tencentcloud_instance_types" "c2m2" {
  exclude_sold_out  = true
  cpu_core_count    = 2
  memory_size       = 2
  availability_zone = var.availability_zones[0]
}

data "tencentcloud_images" "tencentos" {
  instance_type = data.tencentcloud_instance_types.c2m2.instance_types[0].instance_type
  os_name       = "tencentos"
}

module "vpc" {
  source             = "terraform-tencentcloud-modules/vpc/tencentcloud"
  vpc_cidr           = "10.0.0.0/16"
  subnet_cidrs       = ["10.0.1.0/24"]
  availability_zones = var.availability_zones
  vpc_name           = "cvm-test-vpc"
  tags               = var.tags
}

module "cvm" {
  source            = "../../"
  tags              = var.tags
  vpc_id            = module.vpc.vpc_id
  subnet_id         = module.vpc.subnet_id[0]
  availability_zone = module.vpc.availability_zones[0]
  instance_type     = data.tencentcloud_instance_types.c2m2.instance_types[0].instance_type
  image_id          = data.tencentcloud_images.tencentos.images[0].image_id

  data_disk_count = 2
  data_disk_size  = 10
}