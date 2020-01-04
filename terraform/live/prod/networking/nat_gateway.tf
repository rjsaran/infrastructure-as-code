module "nat_gateway" {
    source      = "../../../modules/networking/nat-gateway"
    vpc_id      = module.vpc.vpc_id
    subnet_id   = module.subnet_public.public_subnet_ids[0]
}