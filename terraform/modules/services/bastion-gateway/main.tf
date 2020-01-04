# Bastion gateway Security Group
module "bastion_gateway_sg" {
    source       = "terraform-aws-modules/security-group/aws"

    vpc_id       = var.vpc_id

    name         = "bastion_gateway_sg"
    description  = "Allow SSH from All"

    ingress_with_cidr_blocks = [
        {
            from_port   = 22
            to_port     = 22
            protocol    = "tcp"
            cidr_blocks = "0.0.0.0/0"
        }
    ]

    egress_with_cidr_blocks = [
        {
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_blocks = "0.0.0.0/0"
        }
    ]

     tags = {
        Name        = "bastion_gateway_sg"
        Environment = var.environment
        Tool        = "Terraform"
    }
}

# Bastion Gateway Auto Scaling Group
module "bastion_gateway_asg" {
    source              = "../../networking/auto-scaling-group"

    image_id            = var.image_id

    instance_type       = var.instance_type
    key_name            = var.key_name
    security_groups     = [module.bastion_gateway_sg.this_security_group_id]

    min_size            = var.min_size
    max_size            = var.max_size

    vpc_zone_identifier = var.vpc_zone_identifier

    name                = "bastion_gateway_asg"
    environment         = var.environment
}