# Terraform AWS API Gateway Lambda DynamoDB

### Terraform module for AWS API Gateway Lambda DynamoDB infrastructure
[![MIT License](https://img.shields.io/npm/l/terraform-api-gateway-lambda-dynamodb.svg)](http://opensource.org/licenses/MIT)
![stability-stable](https://img.shields.io/badge/stability-stable-green.svg)

## Table of Contents
* [Features](#features)
* [Usage](#usage)
* [Deployment](#deployment)
* [Example](#example)

## Features
Terraform module which deploys a serverless HTTP endpoint backed by AWS API Gateway, Lambda & DynamoDB
 
**API Gateway**

This module is created with a single stage that is given as parameter.
The path is `/api/messages`.
I will expand this in later versions to be user provided.

**Lambda**

This module is created with full customization by user.

**DynamoDB**

This module is optional. Lambda is created with R/W permission for DynamoDB to allow Lambda creation of tables or optionally to create them before-hand with this script.

## Usage
```hcl-terraform
module "api-gateway-lambda-dynamodb" {
  source  = "crisboarna/api-gateway-lambda-dynamodb/aws"
  version = "0.1.1"

  # insert the 10 required variables here
}
```

## Deployment
1. Run build process to generate Lambda ZIP file locally to match `lambda_zip_path` variable path
2. Provide all needed variables from `variables.tf` file or copy paste and change example below
3. Create/Select Terraform workspace before deployment
4. Run `terraform plan -var-file="<.tfvars file>` to check for any errors and see what will be built
5. Run `terraform apply -var-file="<.tfvars file>` to deploy infrastructure

**Example Deployment Script**
```js
#!/usr/bin/env bah

if [[ ! -d .terraform ]]; then
  terraform init
fi
if ! terraform workspace list 2>&1 | grep -qi "$ENVIRONMENT"; then
  terraform workspace new "$ENVIRONMENT"
fi
terraform workspace select "$ENVIRONMENT"
terraform get
terraform plan -var-file=$1
terraform apply -var-file=$1
```

## Example
```hcl-terraform
module "api_lambda_dynamodb" {
  source  = "crisboarna/terraform-aws-api-gateway-lambda-dynamodb"
  version = "v0.1.0"

  #Global
  region = "eu-west-1"
  project = "Awesome Project"
   
  #API Gateway
  api_gw_method = "POST"

  #Lambda
  lambda_function_name = "Awesome Endpoint"
  lambda_description = "Awesome HTTP Endpoint Lambda"
  lambda_runtime = "nodejs8.10"
  lambda_handler = "dist/bin/lambda.handler"
  lambda_timeout = 30
  lambda_code_s3_bucket = "awesome-project-bucket"
  lambda_code_s3_key = "awesome-project.zip"
  lambda_code_s3_storage_class = "ONEZONE_IA"
  lambda_code_s3_bucket_visibility = "private"
  lambda_zip_path = "../../awesome-project.zip"
  lambda_memory_size = 256
  
  #DynamoDB
  table_data = [
    { 
      name = "Awesome Project Table 1"
    },
    {
      name = "Awesome Project Table 2",
      read_capacity = 2,
      write_capacity = 3
    }
  ]
  #Tags
  tags = {
    project = "Awesome Project"
    managedby = "Terraform"
  }
  
  #Lambda Environment variables
  environmentVariables = {
    NODE_ENV = "production"
  }
  
  
}
```