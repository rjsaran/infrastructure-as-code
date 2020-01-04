# outputs produced at the end of a terraform apply:

# NAME of the VPC
output "vpc_name" {
    value = var.name
}

# CIDR block of VPC
output "cidr_block" {
    value = var.cidr_block
}

# ID of the VPC
output "vpc_id" {
    value = aws_vpc.this.id
}