resource "aws_iam_role" "lambda-role" {
  name = "${var.lambda_name}-Role"
  assume_role_policy = "${file("${path.module}/lambda-role.json")}"
}

resource "aws_iam_role_policy" "DynamoDB-ReadWrite" {
  name = "${aws_iam_role.lambda-role.name}-Role"
  role = "${aws_iam_role.lambda-role.id}"
  policy = "${file("${path.module}/dynamodb-policy.json")}"
}

resource "aws_iam_role_policy_attachment" "Lambda-CloudWatch-Logs-ReadWrite" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  role = "${aws_iam_role.lambda-role.name}"
}

resource "aws_iam_role" "apigw-role" {
  name = "${var.api_gw_name}-Role"
  assume_role_policy = "${file("${path.module}/apigw-role.json")}"
}

resource "aws_iam_role_policy_attachment" "API-GW-CloudWatch-Logs-ReadWrite" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  role = "${aws_iam_role.apigw-role.name}"
}

