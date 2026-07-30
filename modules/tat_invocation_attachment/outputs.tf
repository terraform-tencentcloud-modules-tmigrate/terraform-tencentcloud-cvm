output "invocation_ids" {
  value       = { for k, v in tencentcloud_tat_invocation_invoke_attachment.this : k => v.invocation_id }
  description = "Map of invocation IDs keyed by instance logical name."
}
