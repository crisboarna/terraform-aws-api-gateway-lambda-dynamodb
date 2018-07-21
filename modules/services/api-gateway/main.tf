data "aws_caller_identity" "current" {}

resource "aws_api_gateway_rest_api" "api" {
  name = "${var.api_gw_name}"
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  stage_name = "${var.stage_name}"
  depends_on = ["aws_api_gateway_integration.request_method_integration","aws_api_gateway_integration_response.response_method_integration"]
}

resource "aws_api_gateway_resource" "api_resource" {
  parent_id = "${aws_api_gateway_rest_api.api.root_resource_id}"
  path_part = "api"
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
}

resource "aws_api_gateway_resource" "messages_resource" {
  parent_id = "${aws_api_gateway_resource.api_resource.id}"
  path_part = "messages"
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
}

resource "aws_api_gateway_method" "request_method" {
  authorization = "NONE"
  http_method = "${var.method}"
  resource_id = "${aws_api_gateway_resource.messages_resource.id}"
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
}

resource "aws_api_gateway_integration" "request_method_integration" {
  http_method = "${aws_api_gateway_method.request_method.http_method}"
  resource_id = "${aws_api_gateway_resource.messages_resource.id}"
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  type = "AWS_PROXY"
  uri = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda_arn}/invocations"
  integration_http_method = "POST"
}

resource "aws_api_gateway_method_response" "response_method" {
  http_method = "${aws_api_gateway_integration.request_method_integration.http_method}"
  resource_id = "${aws_api_gateway_resource.messages_resource.id}"
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "response_method_integration" {
  http_method = "${aws_api_gateway_method_response.response_method.http_method}"
  resource_id = "${aws_api_gateway_resource.messages_resource.id}"
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  status_code = "${aws_api_gateway_method_response.response_method.status_code}"
}

resource "aws_lambda_permission" "apigw-lambda-allow" {
  action = "lambda:InvokeFunction"
  function_name = "${var.lambda_name}"
  principal = "apigateway.amazonaws.com"
  statement_id = "AllowExecutionFromApiGateway"
  depends_on = ["aws_api_gateway_rest_api.api","aws_api_gateway_resource.messages_resource"]
  source_arn = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.api.id}/*/*"
}