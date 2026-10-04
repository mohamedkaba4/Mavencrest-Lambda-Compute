resource "aws_lambda_function" "storefront" {
  function_name = "mavencrest-storefront-lambda"

  role         = aws_iam_role.lambda_execution.arn
  package_type = "Image"

  image_uri = "${aws_ecr_repository.mavencrest_lambda.repository_url}:v2"

  architectures = ["arm64"]

  memory_size = 1024
  timeout     = 30

  environment {
    variables = {
      DATABASE_URL         = var.database_url
      NEXTAUTH_SECRET      = var.nextauth_secret
      GOOGLE_CLIENT_ID     = var.google_client_id
      GOOGLE_CLIENT_SECRET = var.google_client_secret
      GITHUB_ID            = var.github_id
      GITHUB_SECRET        = var.github_secret
    }
  }
}

resource "aws_lambda_function_url" "storefront" {
  function_name      = aws_lambda_function.storefront.function_name
  authorization_type = "AWS_IAM"
}
