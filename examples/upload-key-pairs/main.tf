module "key-pairs" {
  source = "../../modules/upload-key-pairs"
#  source = "git::https://github.com/terraform-tencentcloud-modules-tmigrate/terraform-tencentcloud-cvm.git//modules/upload-key-pairs?ref=master"
  key_pairs = {
    demo = {
      key_name   = "demo"
      public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDEH3iFTmaRyYBzWQEDOpxz7A+lFWqI9Vdils0y+AL0gJpM+GoFYWY1FfUK8Us1eqa1tjJlB/YDFRZ7Kilh+tzefAcDH2jm6SzZsJcDDCrIwOPgEyAhr6281Du+08MSNHZ5FcEhXsZPjJQPHr2mbLfqEHj7tQ6iGJSUOI2sscSwQk3y2HnXgkdHzbHKwqxjjhcHoomu2Xt8haXgDGdlvnOQ6OPqCFk+e2XydJTFmM9IRhaQl6Lp5tL+WjMb5v0U8JDd1woYxw1iLSVQflPOdQf/alHAVBpidhss+wVuBOZSno9Abq7yHlGmOYjwjglbG0lu8+3n9hW1jzTmjnN4XeUYZMprcl6bf9uZ3c1LnrPaHQ3u8ypIUO72MBpIQF7tzTUr6U8Mc+tQJ1TnpYp4Jjbco9cpXwC7PV4tF4Ua9nk2h+IacAZ9t85xuXAlFx39KmD1OvYfyi+fYZGAdbaNZE4/bcvwomrxoIDg8NcdVAFoWGY4eeiKTQmXo1MR4gd97HU="
      project_id = 0
      tags       = {}
    }
  }
}