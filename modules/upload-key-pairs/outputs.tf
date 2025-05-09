output "key_ids" {
  value =  {for key_name, key in tencentcloud_key_pair.foo: key_name => key.id }
}