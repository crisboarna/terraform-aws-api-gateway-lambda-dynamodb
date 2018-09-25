data "template_file" "lambda_dynamodb_policy" {
  count = "${length(var.dynamodb_policy_action_list) >= 0 ? 1 : 0}"
  template = "${file("${path.module}/dynamodb-policy.json")}"
  vars {
    policy_arn_list = "${join(", ", formatlist("\"%s\"", var.dynamodb_arn_list))}"
    policy_action_list = "${join(", ", formatlist("\"%s\"", var.dynamodb_policy_action_list))}"
  }
}

resource "aws_iam_role_policy" "DynamoDB-Policy" {
  count = "${length(var.dynamodb_arn_list) > 0 ? 1 : 0}"
  name = "${aws_iam_role.lambda-role.name}-Policy"
  role = "${aws_iam_role.lambda-role.id}"
  policy = "${data.template_file.lambda_dynamodb_policy.rendered}"
}

resource "aws_iam_role" "lambda-role" {
  name = "${var.lambda_name}-Role"
  assume_role_policy = "${file("${path.module}/lambda-role.json")}"
}

resource "aws_iam_role" "apigw-role" {
  name = "${var.api_gw_name}-Role"
  assume_role_policy = "${file("${path.module}/apigw-role.json")}"
}

resource "aws_iam_role_policy_attachment" "Lambda-CloudWatch-Logs-ReadWrite" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  role = "${aws_iam_role.lambda-role.name}"
}

resource "aws_iam_role_policy_attachment" "API-GW-CloudWatch-Logs-ReadWrite" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  role = "${aws_iam_role.apigw-role.name}"
}