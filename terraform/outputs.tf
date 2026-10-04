output "ecr_repository_url" {
  description = "Amazon ECR repository URL for the Mavencrest Lambda image"
  value       = aws_ecr_repository.mavencrest_lambda.repository_url
}

output "lambda_function_url" {
  value = aws_lambda_function_url.storefront.function_url
}