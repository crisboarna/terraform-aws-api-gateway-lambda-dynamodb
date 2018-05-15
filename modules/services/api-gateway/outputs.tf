output "api_url" {
  value = "${aws_api_gateway_deployment.deployment.invoke_url}"
}

output "api_gw_id" {
  value = "${aws_api_gateway_rest_api.api.id}"
}

output "api_gw_name" {
  value = "${aws_api_gateway_rest_api.api.name}"
}