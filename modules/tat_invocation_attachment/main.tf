resource "tencentcloud_tat_invocation_invoke_attachment" "this" {
  for_each = var.instance_ids

  instance_id = each.value
  command_id  = var.command_id

  username              = var.username
  working_directory     = var.working_directory
  timeout               = var.timeout
  parameters            = var.parameters
  output_cos_bucket_url = var.output_cos_bucket_url
  output_cos_key_prefix = var.output_cos_key_prefix
}
