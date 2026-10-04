data "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_role" "github_actions_lambda_deploy" {
  name = "mavencrest-github-lambda-deploy"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Federated = data.aws_iam_openid_connect_provider.github.arn
        }

        Action = "sts:AssumeRoleWithWebIdentity"

        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }

          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:mohamedkaba4/E-commerce:*"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "github_actions_lambda_deploy" {
  name = "mavencrest-github-lambda-deploy-policy"
  role = aws_iam_role.github_actions_lambda_deploy.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "ecr:GetAuthorizationToken"
        ]

        Resource = "*"
      },
      {
        Effect = "Allow"

        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage"
        ]

        Resource = aws_ecr_repository.mavencrest_lambda.arn
      },
      {
        Effect = "Allow"

        Action = [
          "lambda:GetFunction",
          "lambda:GetFunctionConfiguration",
          "lambda:UpdateFunctionCode"
        ]

        Resource = aws_lambda_function.storefront.arn
      }
    ]
  })
}

output "github_actions_lambda_role_arn" {
  value = aws_iam_role.github_actions_lambda_deploy.arn
}
