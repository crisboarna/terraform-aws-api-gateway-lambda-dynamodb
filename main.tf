#required otherwise circular dependency between IAM and Lambda
locals {
  lambda_function_name                  = "${var.project}-${var.lambda_function_name}-${terraform.workspace}"
  dynamodb_tables_count                 = length(var.dynamodb_table_properties)
}

module "apigw" {
  source                                = "./modules/services/api-gateway"

  #Setup
  api_gw_name                           = "${var.project}-API-Gateway-${terraform.workspace}"
  api_gw_disable_resource_creation      = var.api_gw_disable_resource_creation
  api_gw_endpoint_configuration_type    = var.api_gw_endpoint_configuration_type
  stage_name                            = terraform.workspace
  method                                = var.api_gw_method
  lambda_arn                            = module.lambda.lambda_arn
  region                                = var.region
  lambda_name                           = module.lambda.lambda_name
  dependency_list                       = var.api_gw_dependency_list
}

module "lambda" {
  source                                = "./modules/services/lambda"

  #Setup
  region                                = var.region
  lambda_function_name                  = local.lambda_function_name
  lambda_description                    = var.lambda_description
  lambda_runtime                        = var.lambda_runtime
  lambda_handler                        = var.lambda_handler
  lambda_timeout                        = var.lambda_timeout
  lambda_file_name                      = var.lambda_file_name
  lambda_code_s3_bucket_existing        = var.lambda_code_s3_bucket_existing
  lambda_code_s3_bucket_new             = var.lambda_code_s3_bucket_new
  lambda_code_s3_bucket_use_existing    = var.lambda_code_s3_bucket_use_existing
  lambda_code_s3_key                    = var.lambda_code_s3_key
  lambda_code_s3_storage_class          = var.lambda_code_s3_storage_class
  lambda_code_s3_bucket_visibility      = var.lambda_code_s3_bucket_visibility
  lambda_zip_path                       = var.lambda_zip_path
  lambda_memory_size                    = var.lambda_memory_size
  lambda_vpc_security_group_ids         = var.lambda_vpc_security_group_ids
  lambda_vpc_subnet_ids                 = var.lambda_vpc_subnet_ids
  lambda_layers                         = var.lambda_layers

  #Internal
  lambda_role                           = module.iam.lambda_role_arn

  #Environment variables
  environment_variables                 = var.environment_variables

  #Tags
  tags                                  = var.tags
}

module "dynamodb" {
  source                                = "./modules/services/dynamodb"

  #Setup
  dynamodb_table_properties             = var.dynamodb_table_properties
  dynamodb_table_attributes             = var.dynamodb_table_attributes
  dynamodb_table_local_secondary_index  = var.dynamodb_table_local_secondary_index
  dynamodb_table_secondary_index        = var.dynamodb_table_secondary_index
  dynamodb_table_ttl                    = var.dynamodb_table_ttl

  #Tags
  tags                                  = var.tags
}

module "iam" {
  source = "./modules/global/iam"

  #Setup
  lambda_name                           = local.lambda_function_name
  lambda_layers                         = var.lambda_layers
  api_gw_name                           = module.apigw.api_gw_name
  api_gw_id                             = module.apigw.api_gw_id
  dynamodb_arn_list                     = module.dynamodb.dynamodb_table_arns
  dynamodb_policy_action_list           = var.dynamodb_policy_action_list
  dynamodb_tables_count                 = local.dynamodb_tables_count
}