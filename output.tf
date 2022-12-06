output "instance_id" {
  description = "ids of instances."
  value       = tencentcloud_instance.instance.*.id
}

output "instance_status" {
  description = "The states of instance."
  value       = local.create_instance ? tencentcloud_instance.instance[0].instance_status : ""
}

output "public_ip" {
  description = "The public ips of instances."
  value       = local.create_instance ? tencentcloud_instance.instance.*.public_ip : ""
}

output "private_ip" {
  description = "The private ips of instances."
  value       = local.create_instance ? tencentcloud_instance.instance.*.private_ip : ""
}