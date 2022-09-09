
output "my_static_ips" {
  value = aws_eip.eip[*].public_ip
}

output "webserver_instance_id" {
  value = aws_instance.app_server[*].id
}
