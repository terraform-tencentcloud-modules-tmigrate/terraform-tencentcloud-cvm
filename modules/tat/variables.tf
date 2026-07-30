variable "create" {
  type    = bool
  default = true
  description = ""
}

variable "command" {
  type = any
  default = {}
  description = "see `tencentcloud_tat_command`"
}

variable "name" {
  type = string
  description = "name of the command"
}

variable "tags" {
  type    = map(string)
  default = {}
  description = "tags for command"
}