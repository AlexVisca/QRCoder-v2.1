# main outputs
output "app_public_ip_address" {
  value = aws_instance.application_A01206859.public_ip
}
output "web_public_ip_address" {
  value = aws_instance.webserver_A01206859.public_ip
}