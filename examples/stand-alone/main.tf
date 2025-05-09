module "key-pairs" {
  source = "../../modules/stand-alone"
#  source = "git::https://github.com/terraform-tencentcloud-modules-tmigrate/terraform-tencentcloud-cvm.git//modules/stand-alone?ref=master"
  disable_automation_service = false

  vpc_id       = "vpc-j0sqtqk7"
  availability_zone     = "ap-singapore-2"
  subnet_id = "subnet-p6xvdq6i"

  tags = {
    created: "terraform"
  }

  project_id   = 0
  instance_type = "S5.MEDIUM4"
  os_name = "Ubuntu Server 22.04 LTS 64"
  system_disk_type  = "CLOUD_SSD"
  system_disk_size  = 20

  security_group_ids = ["sg-19apvmji"]

  data_disks = [
    {
      data_disk_type       = "CLOUD_PREMIUM"
      data_disk_size       = 50
    }
  ]

  create_assume_role = true
  cam_role_name = "cvm-role-test"
  assume_role_policy_name = "ReadOnlyAccess"
  #  user_data = base64encode(file("./init.sh"))
#  user_data_raw = file("./init.sh")

  disable_security_service = false
  disable_monitor_service = false

  action_timer = {
    timer_action = "TerminateInstances" # Timer action, currently only supports destroying one value: TerminateInstances.
    action_time  = "2025-12-31T11:26:40Z" #  Execution time, expressed according to ISO8601 standard and using UTC time. The format is YYYY-MM-DDThh:mm:ssZ. For example, 2018-05-29T11:26:40Z, the execution time must be 5 minutes longer than the current time.
  }
}