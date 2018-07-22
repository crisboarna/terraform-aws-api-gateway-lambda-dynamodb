variable "api_gw_name" {
  description = "The name of the REST API",
}

variable "stage_name" {
  description = "The stage name for the API deployment"
  default = "dev"
}

variable "method" {
  description = "The HTTP method"
  default = "POST"
}

variable "lambda_arn" {
  description = "The ARN of Lambda to invoke"
}

variable "lambda_name" {
  description = "The ARN of Lambda to invoke"
}

variable "region" {
  description = "The AWS region"
}

variable "dependency_list" {
  description = "Deployment dependency list"
  type = "list"
}