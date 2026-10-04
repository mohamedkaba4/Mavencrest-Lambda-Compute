variable "aws_region" {
  type        = string
  description = "AWS region for Mavencrest Lambda resources"
}

variable "database_url" {
  type      = string
  sensitive = true
}

variable "nextauth_secret" {
  type      = string
  sensitive = true
}

variable "google_client_id" {
  type      = string
  sensitive = true
}

variable "google_client_secret" {
  type      = string
  sensitive = true
}

variable "github_id" {
  type      = string
  sensitive = true
}

variable "github_secret" {
  type      = string
  sensitive = true
}
