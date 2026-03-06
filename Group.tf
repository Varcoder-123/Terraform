provider "aws" {
  region = "ap-south-1"
}

variable "user_names" {
  default = ["Ritesh", "Vignesh", "Rahul"]
}

resource "aws_iam_user" "console_user" {
  for_each = toset(var.user_names)
  name = each.value
}

resource "aws_iam_group" "Development_group" {
  name = "Development"
}

resource "aws_iam_user_group_membership" "membership" {
  for_each = aws_iam_user.console_user
  user = each.value.name
  groups = [aws_iam_group.Development_group.name]
}

