# outputs produced at the end of a terraform apply:

# ID of NAT gateway
output "nat_gateway_id" {
    value = aws_nat_gateway.this'.id
}

# IP of NAT gateway
output "nat_gateway_ip" {
    value = aws_eip.this.id
}