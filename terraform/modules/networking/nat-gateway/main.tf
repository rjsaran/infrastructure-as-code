# create an elastic IP and associate to a newly created NAT gateway

# Static IP for Nat Gateway
resource "aws_eip" "this" {
    vpc = true

    tags = {
        Name   = "eip_nat_${var.vpc_id}"
        Tool   = "Terraform"
    }
}

# Nat Gateway
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = var.subnet_id

   tags = {
        Name   = "nat_${var.vpc_id}"
        Tool   = "Terraform"
    }
}