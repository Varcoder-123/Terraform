provider "aws" {
  region = "ap-south-1"
}

resource "aws_iam_user" "console_user" {
  name = "Ritesh"
}

resource "aws_iam_user_login_profile" "console_login" {
  user = aws_iam_user.console_user.name
  password_length = 16
  password_reset_required = true
}

variable "policies" {
  default = [
    "arn:aws:iam::aws:policy/IAMUserChangePassword",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ]
}

resource "aws_iam_user_policy_attachment" "Change_password" {
  for_each = toset(var.policies)
  user = aws_iam_user.console_user.name
  policy_arn = each.value
}

output "iam_username" {
  value = aws_iam_user.console_user.name
}

output "iam_console_password" {
  value = aws_iam_user_login_profile.console_login.password
  sensitive = true
}