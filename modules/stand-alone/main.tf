
locals {
}

data "tencentcloud_images" "this" {
  os_name          = var.image_id == null ? var.os_name : null
  image_type       = var.image_type
  image_id         = var.image_id
  image_name_regex = var.image_id == null ? var.image_name : null
}

data "tencentcloud_instance_types" "these" {
  dynamic "filter" {
    for_each = { for k, v in var.instance_type_filters : k => v if v != null && v != [] }
    content {
      name   = filter.key
      values = filter.value
    }
  }
  cpu_core_count   = var.cpu_core_count
  memory_size      = var.memory_size
  gpu_core_count   = var.gpu_core_count
  exclude_sold_out = true
}

locals {
  instance_id   = var.create ? join("", tencentcloud_instance.cvm_instance.*.id) : ""
  public_ip     = concat(tencentcloud_instance.cvm_instance.*.public_ip, [""])[0]
  user_data     = var.create ? join("", tencentcloud_instance.cvm_instance.*.user_data) : ""
  user_data_raw = try(base64decode(local.user_data), "")
  private_ip    = var.create ? join("", tencentcloud_instance.cvm_instance.*.private_ip) : ""
}


resource "tencentcloud_instance" "cvm_instance" {
  depends_on                 = [tencentcloud_cam_role_policy_attachment_by_name.binding]
  count                      = var.create ? 1 : 0
  vpc_id                     = var.vpc_id
  subnet_id                  = var.subnet_id
  instance_name              = var.instance_name
  hostname                   = var.hostname == null ? var.instance_name : var.hostname
  availability_zone          = var.availability_zone
  image_id                   = data.tencentcloud_images.this.images[0].image_id
  instance_type              = var.instance_type == null ? data.tencentcloud_instance_types.these.instance_types[0].instance_type : var.instance_type
  system_disk_type           = var.system_disk_type
  system_disk_size           = var.system_disk_size
  orderly_security_groups    = var.security_group_ids
  key_ids                    = var.key_ids
  password                   = var.password
  cam_role_name              = var.cam_role_name
  user_data                  = var.user_data == null ? (var.user_data_raw == null ? null : base64encode(var.user_data_raw)) : var.user_data
#  user_data_raw              = var.user_data_raw
  project_id                 = var.project_id
  allocate_public_ip         = var.allocate_public_ip
  internet_max_bandwidth_out = var.internet_max_bandwidth_out

  instance_charge_type                    = var.instance_charge_type
  instance_charge_type_prepaid_period     = var.instance_charge_type_prepaid_period
  instance_charge_type_prepaid_renew_flag = var.instance_charge_type_prepaid_renew_flag

  disable_security_service   = var.disable_security_service
  disable_monitor_service    = var.disable_monitor_service
  disable_automation_service = var.disable_automation_service

  private_ip = var.private_ip

  dynamic "data_disks" {
    for_each = var.data_disks
    content {
      data_disk_type       = try(data_disks.value.type, "CLOUD_PREMIUM")
      data_disk_size       = try(data_disks.value.size, 50)
      delete_with_instance = var.delete_with_instance
    }
  }

  lifecycle {
    ignore_changes = [
      password
    ]
  }
}


resource "tencentcloud_cvm_action_timer" "action_timer" {
  count = var.create && var.action_timer != null ? 1 : 0
  instance_id = local.instance_id

  action_timer {
    timer_action = var.action_timer.timer_action # "TerminateInstances"
    action_time  = var.action_timer.action_time # "2024-11-11T11:26:40Z"
  }
}

resource "tencentcloud_cam_role" "assume_role" {
  count       = var.create_assume_role ? 1 : 0
  name        = var.cam_role_name
  document    = <<EOF
{
  "statement": [
    {
      "action":"name/sts:AssumeRole",
      "effect":"allow",
      "principal":{
        "service":"cvm.qcloud.com"
      }
    }
  ],
  "version":"2.0"
}
EOF
  description = var.assume_role_description
  tags        = var.tags
}


resource "tencentcloud_cam_policy" "assume_role_policy" {
  count       = var.create_assume_role_policy ? 1 : 0
  name        = var.assume_role_policy_name // ForceNew
  document    = var.assume_role_policy_document
  description = var.assume_role_policy_description
}

resource "tencentcloud_cam_role_policy_attachment_by_name" "binding" {
  depends_on = [tencentcloud_cam_role.assume_role, tencentcloud_cam_policy.assume_role_policy]
  count      = var.create_assume_role ? 1 : 0

  role_name   = var.cam_role_name
  policy_name = var.assume_role_policy_name
}
