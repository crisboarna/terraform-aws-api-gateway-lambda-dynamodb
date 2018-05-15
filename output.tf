#API Gateway
output "APIGatewayURL" {
  value = "${module.apigw.api_url}"
}

output "APIGatewayName" {
  value = "${module.apigw.api_gw_name}"
}

output "APIGatewayID" {
  value = "${module.apigw.api_gw_id}"
}

#Lambda
output "LambdaName" {
  value = "${module.lambda.lambda_name}"
}

output "LambdaARN" {
  value = "${module.lambda.lambda_arn}"
}