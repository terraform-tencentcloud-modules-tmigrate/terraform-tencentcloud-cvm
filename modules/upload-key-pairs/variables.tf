variable "key_pairs" {
  type = any
  default = {}
  description = "Map of key_pairs to create. Key pair name is the map key.see `tencentcloud_key_pair` "
}

// The variables below are key descriptions for each resource. They are not used
variable "key_name" {
  type = string
  default = "test-key"
  description = "The key pair's name. It is the only in one TencentCloud account."
}
variable "public_key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQDjd8fTnp7Dcuj4mLaQxf9Zs/ORgUL9fQxRCNKkPgP1paTy1I513maMX126i36Lxxl3+FUB52oVbo/FgwlIfX8hyCnv8MCxqnuSDozf1CD0/wRYHcTWAtgHQHBPCC2nJtod6cVC3kB18KeV4U7zsxmwFeBIxojMOOmcOBuh7+trRw=="
  description = "You can import an existing public key and using TencentCloud key pair to manage it."
}
variable "project_id" {
  type = number
  default = 0
  description = "Specifys to which project the key pair belongs."
}
variable "tags" {
  type = map(string)
  default = {}
  description = "Tags of the key pair."
}