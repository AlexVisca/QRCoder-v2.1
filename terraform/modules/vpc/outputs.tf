# vpc outputs
output "app_subnet_id" {
  value = aws_subnet.app_subnet.id
}

output "application_security_group_id" {
    value = aws_security_group.app_sg.id
}

output "frontend_security_group_id" {
    value = aws_security_group.web_sg.id
}