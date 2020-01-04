# outputs produced at the end of a terraform apply:
output "this_elb_id" {
    description = "The id of the ELB"
    value       = aws_elb.this.id
}

output "this_elb_dns_name" {
    description = "The DNS name of the ELB"
    value       = aws_elb.this.dns_name
}

output "this_elb_name" {
    description = "The name of the ELB"
    value       = aws_elb.this.name
}