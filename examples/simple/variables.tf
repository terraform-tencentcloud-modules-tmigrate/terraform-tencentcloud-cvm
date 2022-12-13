variable "tags" {
  type = map(string)
  default = {
    test = "shelton"
  }
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-guangzhou-6"]
}
