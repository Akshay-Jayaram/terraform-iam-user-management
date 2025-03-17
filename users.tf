locals {
  users_from_yaml = yamldecode(file("${path.module}/user-roles.yaml")).users
  users_map       = { for user_config in local.users_from_yaml : user_config.username => user_config.roles }
}

resource "aws_iam_user" "users" {
  #for_each = [for user_config in local.users_from_yaml : user_config.username]
  for_each = toset(local.users_from_yaml[*].username) #convert list to set
  name     = each.value
  tags = {
    createdby = "terraform"
    user      = "${each.value}"
  }
}

resource "aws_iam_user_login_profile" "user_password" {
  for_each        = aws_iam_user.users
  user            = each.value.name
  password_length = 8
  #pgp_key = "keybase:some_person_that_exists"  recommended

  #if changes are made, it won't affect the existing users and apply for new users
  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key
    ]
  }
}

#not recommended: To retrieve it, run terraform output passwords
output "passwords" {
  sensitive = true
  value     = { for user, user_login in aws_iam_user_login_profile.user_password : user => user_login.password }
}

output "users" {
  value = local.users_from_yaml
}
