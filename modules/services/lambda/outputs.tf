output "lambda_name" {
  value = "${aws_lambda_function.lambda.function_name}"
}

output "lambda_arn" {
  value = "${aws_lambda_function.lambda.arn}"
}

output "lambda_s3_bucket" {
  value = "${aws_s3_bucket.lambda_repo.*.bucket}"
}