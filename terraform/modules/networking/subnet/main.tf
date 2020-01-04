# Subnet
resource "aws_subnet" "subnet" {
    vpc_id                  = var.vpc_id
    map_public_ip_on_launch = var.map_public_ip_on_launch

    count                   = length(var.subnets)
    cidr_block              = element(values(var.subnets), count.index)
    availability_zone       = element(keys(var.subnets), count.index)

    tags = {
        Name        = "${var.purpose}_${element(keys(var.subnets), count.index)}_${element(values(var.subnets), count.index)}"
        Environment = var.environment
        Tool        = "Terraform"
    }
}

# associate private routing table with subnet
resource "aws_route_table_association" "subnet_route_association" {
    count          = length(var.subnets)

    subnet_id      = aws_subnet.subnet[count.index].id
    route_table_id = var.route_table_id
}