
locals {
  // TODO naming convention
  name = var.name
  command_id = var.create ? concat(tencentcloud_tat_command.command.*.id, [""])[0] : ""
}

resource "tencentcloud_tat_command" "command" {
  count = var.create ? 1 : 0
  username              = try(var.command.username, "root")          # "root"
  command_name          = local.name      # "ls"
  content               = try(var.command.content ,"#!/bin/bash") #  command content
  description           = try(var.command.description, "")      # "xxx"
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