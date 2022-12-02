output "instance_id" {
  description = "ids of instances."
  value       = tencentcloud_instance.instance.*.id
}

output "instance_status" {
  description = "The states of instance."
  value       = tencentcloud_instance.instance.*.instance_status
}

output "public_ip" {
  description = "The public ips of instances."
  value       = tencentcloud_instance.instance.*.public_ip
}

output "private_ip" {
  description = "The private ips of instances."
  value       = tencentcloud_instance.instance.*.private_ip
}