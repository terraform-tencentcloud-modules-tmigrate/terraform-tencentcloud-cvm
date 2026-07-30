variable "create" {
  type        = bool
  default     = true
  description = "Whether to create resources."
}

variable "name" {
  type        = string
  description = "Name of the TAT command."
}

variable "command" {
  type        = any
  default     = {}
  description = "TAT command config: content, command_type, username, working_directory, timeout, description, output_cos_bucket_url, output_cos_key_prefix"
}

variable "invocation" {
  type        = any
  default     = {}
  description = "Invocation overrides: username, working_directory, timeout, parameters, output_cos_bucket_url, output_cos_key_prefix. Falls back to command values if not set."
}

variable "instance_ids" {
  type        = map(string)
  description = "Map of CVM instance IDs to execute the command on. Key = logical name, Value = instance ID. e.g. { web1 = \"ins-xxx\", web2 = \"ins-yyy\" }"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for the TAT command."
}
