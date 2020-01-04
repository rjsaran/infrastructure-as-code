# create internet gateway, to be associated to a VPC
resource "aws_internet_gateway" "this" {
    vpc_id = var.vpc_id

    tags = {
        Name        = "igw_${var.vpc_id}"
        Environment = var.environment
        Tool        = "Terraform"
    }
}