variable "command_id" {
  type        = string
  description = "TAT command ID to invoke."
}

variable "instance_ids" {
  type        = map(string)
  description = "Map of CVM instance IDs to execute the command on. Key = logical name, Value = instance ID. e.g. { web1 = \"ins-xxx\", web2 = \"ins-yyy\" }"
}

variable "username" {
  type        = string
  default     = "root"
  description = "The user who executes the command. Default root for Linux, System for Windows."
}

variable "working_directory" {
  type        = string
  default     = "/root"
  description = "Command execution path. Use C:\\ for Windows PowerShell."
}

variable "timeout" {
  type        = number
  default     = 60
  description = "Command timeout in seconds. Range [1, 86400]."
}

variable "parameters" {
  type        = string
  default     = null
  description = "Custom parameters as JSON string, e.g. {\"varA\":\"222\"}."
}

variable "output_cos_bucket_url" {
  type        = string
  default     = null
  description = "COS bucket URL for uploading logs."
}

variable "output_cos_key_prefix" {
  type        = string
  default     = null
  description = "COS bucket directory for logs."
}
