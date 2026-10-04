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
      SSM_PARAMETER_PREFIX = "/nextjs/prod"
    }
  }

  lifecycle {
    ignore_changes = [
      image_uri
    ]
  }
}

resource "aws_lambda_function_url" "storefront" {
  function_name      = aws_lambda_function.storefront.function_name
  authorization_type = "AWS_IAM"
}
