output "api_url" {
  value = "${aws_api_gateway_deployment.deployment.invoke_url}"
}

output "api_gw_id" {
  value = "${aws_api_gateway_rest_api.api.id}"
}

output "api_gw_name" {
  value = "${aws_api_gateway_rest_api.api.name}"
}

output "api_gw_root_resource_id" {
  value = "${aws_api_gateway_rest_api.api.root_resource_id}"
}