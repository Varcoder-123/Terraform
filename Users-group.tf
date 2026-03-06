    provider "aws" {
    region = "ap-south-1"
    }

    variable "devops_user" {
    default = ["Vignesh","Karthik"]
    }

    variable "dev_user" {
    default = ["Ritesh"]
    }

    resource "aws_iam_user" "console_user" {
     for_each = toset(concat(var.devops_user, var.dev_user))
     name     = each.value
    }

    resource "aws_iam_group" "devops_group" {
    name = "devops"
    }

    resource "aws_iam_group" "development_group" {
    name = "development"
    }

    resource "aws_iam_user_group_membership" "devops_membership" {
    for_each = toset(var.devops_user)
    user = each.value
    groups = [ aws_iam_group.devops_group.name]
    }

    resource "aws_iam_user_group_membership" "devlopement_membership" {
    for_each = toset(var.dev_user)
    user = each.value
    groups = [ aws_iam_group.development_group.name]
    }

    resource "aws_iam_group_policy_attachment" "devops_policies" {
      group = aws_iam_group.devops_group.name
      policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    }

    resource "aws_iam_group_policy_attachment" "development_policies" {
      group = aws_iam_group.development_group.name
      policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
    }