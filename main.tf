#required otherwise circular dependency between IAM and Lambda
locals {
  lambda_function_name = "${var.project}-${var.lambda_function_name}-${terraform.workspace}"
}

module "apigw" {
  source = "./modules/services/api-gateway"

  #Setup
  api_gw_name = "${var.project}-API-Gateway-${terraform.workspace}"
  stage_name = "${terraform.workspace}"
  method = "${var.api_gw_method}"
  lambda_arn = "${module.lambda.lambda_arn}"
  region = "${var.region}"
  lambda_name = "${module.lambda.lambda_name}"
}

module "lambda" {
  source = "./modules/services/lambda"

  #Setup
  region = "${var.region}"
  lambda_function_name = "${local.lambda_function_name}"
  lambda_description = "${var.lambda_description}"
  lambda_runtime = "${var.lambda_runtime}"
  lambda_handler = "${var.lambda_handler}"
  lambda_timeout = "${var.lambda_timeout}"
  lambda_code_s3_bucket = "${var.lambda_code_s3_bucket}"
  lambda_code_s3_key = "${var.lambda_code_s3_key}"
  lambda_code_s3_storage_class = "${var.lambda_code_s3_storage_class}"
  lambda_code_s3_bucket_visibility = "${var.lambda_code_s3_bucket_visibility}"
  lambda_zip_path = "${var.lambda_zip_path}"

  #Internal
  lambda_role = "${module.iam.lambda_role_arn}"

  #Environment variables
  environmentVariables = "${var.environmentVariables}"

  #Tags
  tags = "${var.tags}"
}

module "dynamodb" {
  source = "./modules/services/dynamodb"

  #Setup
  table_data = "${var.dynamodbTableData}"

  #Tags
  tags = "${var.tags}"
}

module "iam" {
  source = "./modules/global/iam"

  #Setup
  region = "${var.region}"
  project = "${var.project}"
  lambda_name = "${local.lambda_function_name}"
  api_gw_name = "${module.apigw.api_gw_name}"
  api_gw_id = "${module.apigw.api_gw_id}"
}