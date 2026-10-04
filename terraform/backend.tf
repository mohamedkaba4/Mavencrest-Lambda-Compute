terraform {
  backend "s3" {
    bucket       = "mc-lambda-state"
    key          = "lambda/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
