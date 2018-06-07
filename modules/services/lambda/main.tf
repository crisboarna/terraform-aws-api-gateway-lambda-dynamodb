resource "aws_lambda_function" "lambda" {
  function_name = "${var.lambda_function_name}"
  description = "${var.lambda_description}"
  runtime = "${var.lambda_runtime}"
  handler = "${var.lambda_handler}"
  role = "${var.lambda_role}"
  timeout = "${var.lambda_timeout}"
  source_code_hash = "${aws_s3_bucket_object.lambda_dist.etag}"
  s3_bucket = "${aws_s3_bucket.lambda_repo.bucket}"
  s3_key = "${var.lambda_code_s3_key}"
  memory_size = "${var.lambda_memory_size}"

  environment {
    variables = "${var.environment_variables}"
  }

  tags = "${var.tags}"
}

resource "aws_s3_bucket" "lambda_repo" {
  bucket = "${var.lambda_code_s3_bucket}"
  region = "${var.region}"
  acl = "${var.lambda_code_s3_bucket_visibility}"
  tags = "${var.tags}"
}

resource "aws_s3_bucket_object" "lambda_dist" {
  bucket = "${aws_s3_bucket.lambda_repo.bucket}"
  key = "${var.lambda_code_s3_key}"
  source = "${var.lambda_zip_path}"
  etag = "${md5(file(var.lambda_zip_path))}"
  storage_class = "${var.lambda_code_s3_storage_class}"
}