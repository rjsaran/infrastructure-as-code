# create a private route table, to be included as part of private subnet modules
# and associated to a NAT gateway

module "route_table_private" {
    source        = "./../route-table"
    vpc_id        = var.vpc_id
    cidr_block    = var.cidr_block
    gateway_id    = var.gateway_id
    environment   = var.environment
    purpose       = "private"
}
