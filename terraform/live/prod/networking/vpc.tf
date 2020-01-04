module "vpc" {
    source      = "../../../modules/networking/vpc"

    name        = var.vpc_name
    cidr_block  = var.vpc_cidr_block
    environment = var.environment
}