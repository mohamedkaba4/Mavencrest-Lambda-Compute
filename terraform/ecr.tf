resource "aws_ecr_repository" "mavencrest_lambda" {
  name                 = "mavencrest-lambda"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
