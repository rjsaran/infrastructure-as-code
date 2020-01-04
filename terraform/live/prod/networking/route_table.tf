# Route Table: Public
module "route_table_public" {
    source         = "../../../modules/networking/route-table-public"
    vpc_id         = module.vpc.vpc_id
    cidr_block     = "0.0.0.0/0"
    gateway_id     = module.igw.igw_id
    environment    = var.environment
}

# Route Table: Private
module "route_table_private" {
    source         = "../../../modules/networking/route-table-private"
    vpc_id         = module.vpc.vpc_id
    cidr_block     = "0.0.0.0/0"
    gateway_id     = module.nat_gateway.nat_gateway_id
    environment    = var.environment
}