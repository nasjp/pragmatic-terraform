output "operation_instance_id" {
  value = aws_instance.example_for_operation.id
}

output "alb_dns_name" {
  value = aws_lb.example.dns_name
}

