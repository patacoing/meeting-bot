# Input variable definitions

variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "eu-west-3"
}

variable "aws_access_key" {
  description = "AWS access key"

  type    = string
}

variable "aws_secret_key" {
  description = "AWS secret key"

  type    = string
}

variable "meeting_bot_zip_name" {
  description = "Meeting bot zip file name"

  type    = string
}

