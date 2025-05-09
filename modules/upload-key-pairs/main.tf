resource "tencentcloud_key_pair" "foo" {
  for_each = var.key_pairs
  key_name   = try(each.value.key_name, each.key)
  public_key = each.value.public_key
  project_id = try(each.value.project_id, 0)
  tags = try(each.value.tags, {})
}


