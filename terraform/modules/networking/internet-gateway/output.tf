# outputs produced at the end of a terraform apply:

# ID of internet gateway
output "igw_id" {
    value = aws_internet_gateway.this.id
}