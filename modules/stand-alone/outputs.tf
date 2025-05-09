output "cvm_instance_id" {
  value       = local.instance_id
  description = "CVM Ids"
}

output "public_ips" {
  value = local.public_ip
}

output "user_data_raw" {
  value = local.user_data_raw
}

output "user_data" {
  value = local.user_data
}


output "private_ip" {
  value = local.private_ip
}