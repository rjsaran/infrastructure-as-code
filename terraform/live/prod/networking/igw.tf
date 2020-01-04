module "igw"{
    source      = "../../../modules/networking/internet-gateway"

    environment = var.environment
    vpc_id      = module.vpc.vpc_id
}