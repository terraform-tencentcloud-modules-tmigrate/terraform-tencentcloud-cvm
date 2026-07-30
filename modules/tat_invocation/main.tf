locals {
  command_id = var.create ? concat(tencentcloud_tat_command.command.*.id, [""])[0] : ""
}

resource "tencentcloud_tat_command" "command" {
  count = var.create ? 1 : 0

  username              = try(var.command.username, "root")
  command_name          = var.name
  content               = try(var.command.content, "#!/bin/bash")
  description           = try(var.command.description, "")
  command_type          = try(var.command.command_type, "SHELL")
  working_directory     = try(var.command.working_directory, "/root")
  timeout               = try(var.command.timeout, 50)
  output_cos_bucket_url = try(var.command.output_cos_bucket_url, null)
  output_cos_key_prefix = try(var.command.output_cos_key_prefix, null)

  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }
}

# 对每个 CVM 实例执行命令
resource "tencentcloud_tat_invocation_invoke_attachment" "this" {
  for_each = var.create ? var.instance_ids : {}

  instance_id = each.value
  command_id  = local.command_id

  username           = try(var.invocation.username, try(var.command.username, "root"))
  working_directory  = try(var.invocation.working_directory, try(var.command.working_directory, "/root"))
  timeout            = try(var.invocation.timeout, try(var.command.timeout, 50))
  parameters         = try(var.invocation.parameters, null)
  output_cos_bucket_url = try(var.invocation.output_cos_bucket_url, null)
  output_cos_key_prefix = try(var.invocation.output_cos_key_prefix, null)

  depends_on = [tencentcloud_tat_command.command]
}
