# Subnets : Public
module "subnet_public" {
    source            = "../../../modules/networking/subnet-public"

    vpc_id            = module.vpc.vpc_id
    route_table_id    = module.route_table_public.public_route_table_id
    subnets           = var.public_subnets
    environment       = var.environment
}

# Subnets : Private
module "subnet_private" {
    source            = "../../../modules/networking/subnet-private"

    vpc_id            = module.vpc.vpc_id
    route_table_id    = module.route_table_private.private_route_table_id
    subnets           = var.private_subnets
    environment       = var.environment
}