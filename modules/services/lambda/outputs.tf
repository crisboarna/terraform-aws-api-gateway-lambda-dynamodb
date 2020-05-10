output "lambda_name" {
  value = var.lambda_file_name == "defaultLambdaFile.zip" ? join(",",aws_lambda_function.lambda_s3.*.function_name) : join(",", aws_lambda_function.lambda_file.*.function_name)
}

output "lambda_arn" {
  value = var.lambda_file_name == "defaultLambdaFile.zip" ? join(",",aws_lambda_function.lambda_s3.*.arn) : join(",", aws_lambda_function.lambda_file.*.arn)
}

output "lambda_s3_bucket" {
  value = var.lambda_file_name == "defaultLambdaFile.zip" ? join(",",aws_s3_bucket.lambda_repo.*.bucket) : ""
}