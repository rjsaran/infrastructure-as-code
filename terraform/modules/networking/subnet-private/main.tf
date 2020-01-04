# create a private subnet in an availability zone
module "subnet_private" {
    source                  = "./../subnet"
    vpc_id                  = var.vpc_id
    subnets                 = var.subnets
    route_table_id          = var.route_table_id
    environment             = var.environment
    purpose                 = "private"
    map_public_ip_on_launch = "false"
}