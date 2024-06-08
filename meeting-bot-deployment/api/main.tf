terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.51.1"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }
  }

  required_version = ">= 1.2.0"

  backend "s3" {
    bucket = "meeting-bot"
    key    = "api/terraform.tfstate"
    region = "eu-west-3"
  }
}

provider "aws" {
  region = var.aws_region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

resource "aws_iam_role" "meeting_role" {
  name               = "meeting_role_api"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "meeting_role_policy" {
  name   = "meeting_role_api_policy"
  role   = aws_iam_role.meeting_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "iam:PassRole",
          "scheduler:CreateSchedule",
          "scheduler:DeleteSchedule",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_lambda_function_url" "meeting_bot_url" {
  function_name = aws_lambda_function.meeting_bot.function_name
  authorization_type = "NONE"
}

resource "aws_lambda_function" "meeting_bot" {
  filename = var.meeting_bot_zip_name
  function_name = "meeting_bot_api"
  runtime = "python3.11"
  handler = "app.main"
  source_code_hash = filebase64sha256(var.meeting_bot_zip_name)
  role = aws_iam_role.meeting_role.arn

    environment {
        variables = {
          APP_ID = var.app_id
          SERVER_ID = var.server_id
          CALLBACK_SCHEDULE_ARN = var.callback_schedule_arn
          ROLE_ARN = var.role_arn
        }
    }
}