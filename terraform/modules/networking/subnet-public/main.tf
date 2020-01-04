# create a public subnet in an availability zone
module "subnet_public" {
    source                  = "./../subnet"
    vpc_id                  = var.vpc_id
    subnets                 = var.subnets
    route_table_id          = var.route_table_id
    environment             = var.environment
    purpose                 = "public"
    map_public_ip_on_launch = "true"
}