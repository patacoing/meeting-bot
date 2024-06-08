# Input variable definitions

variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "eu-west-3"
}

variable "aws_access_key_id" {
  description = "AWS access key"

  type    = string
}

variable "aws_secret_access_key" {
  description = "AWS secret key"

  type    = string
}

variable "meeting_bot_zip_name" {
  description = "Meeting bot zip file name"

  type    = string
}

variable "app_id" {
  description = "App ID"

  type    = string
}

variable "server_id" {
  description = "Server ID"

  type    = string
}

variable "callback_schedule_arn" {
  description = "Callback schedule ARN"

  type    = string
}

variable "role_arn" {
  description = "Role ARN"

  type    = string
}

variable "client_public_key" {
  description = "Client public key"

  type    = string
}

