variable "region" {
  default = ""
}

variable "project_id" {
  default = 0
}

#cvm
variable "number_of_instances" {
  default = 1
}

variable "instance_name" {
  default = ""
}

variable "availability_zone" {
  default = ""
}

variable "image_id" {
  default = ""
}

variable "instance_type" {
  default = ""
}

variable "system_disk_type" {
  default = "CLOUD_PREMIUM"
}

variable "system_disk_size" {
  default = 50
}

variable "allocate_public_ip" {
  default = true
}
variable "vpc_id" {
  default = ""
}

variable "subnet_id" {
  default = ""
}

variable "internet_max_bandwidth_out" {
  default = 10
}

variable "key_name" {
  default = ""
}
variable "security_groups" {
  type    = list(string)
  default = [""]
}

variable "data_disk_type" {
  default = "CLOUD_PREMIUM"
}

variable "data_disk_size" {
  default = 10
}

variable "data_disk_encryption" {
  default = false
}

variable "instance_tags" {
  type    = map(string)
  default = {}
}
