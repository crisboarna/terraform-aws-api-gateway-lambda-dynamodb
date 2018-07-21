variable "lambda_name" {
  description = "The name of the Lambda function"
}

variable "api_gw_name" {
  description = "The name of the API Gateway"
}

variable "api_gw_id" {
  description = "The API GW ID"
}

variable "dynamodb_arn_list" {
  type = "list"
  description = "List of ARN's to allow permissions for"
}

variable "dynamodb_policy_action_list" {
  type = "list"
  description = "List of ARN's to allow permissions for"
}