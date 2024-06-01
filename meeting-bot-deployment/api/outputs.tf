# Output value definitions

output "function_url" {
  description = "Url of the Lambda function."

  value = aws_lambda_function_url.meeting_bot_url.function_url
}
