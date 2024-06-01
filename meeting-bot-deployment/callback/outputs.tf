# Output value definitions

output "function_arn" {
  description = "Arn of the Lambda function."

  value = aws_lambda_function.meeting_bot_callback.arn
}

output "role_arn" {
  description = "Arn of the Lambda function's role."

  value = aws_iam_role.meeting_role.arn
}
