# create a private route table, to be included as part of private subnet modules
# and associated to a NAT gateway

# Route Table
resource "aws_route_table" "this" {
    vpc_id = var.vpc_id

    route {
        cidr_block = var.cidr_block
        gateway_id = var.gateway_id
    }

    tags = {
        Name        = "${var.purpose}_rt_${var.vpc_id}"
        Environment = var.environment
        Tool        = "Terraform"
    }
}