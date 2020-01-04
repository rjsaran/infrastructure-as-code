# outputs produced at the end of a terraform apply:

output "this_lb_id" {
  description = "The ID and ARN of the load balancer we created."
  value       = aws_lb.this[0].id
}

output "this_lb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = aws_lb.this[0].dns_name
}