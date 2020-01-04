# Use Mgmt VPC 
data "terraform_remote_state" "networking_prod" {
    backend = "s3"

    config = {
        bucket  = "terraform-state-2020-01-01"
        region  = "ap-southeast-1"
        key     = "prod/networking/terraform.tfstate"
    }
}

data "terraform_remote_state" "key_pair_global" {
    backend = "s3"

    config = {
        bucket  = "terraform-state-2020-01-01"
        region  = "ap-southeast-1"
        key     = "global/key_pair/terraform.tfstate"
    }
}

data "aws_ami" "this" {
    most_recent = true
    owners      = ["self"]

    filter {
        name   = "name"
        
        values = ["packer-linux-bastion-*"]
    }
}

locals {
    vpc_id           = data.terraform_remote_state.networking_prod.outputs.vpc_id
    public_subnets   = data.terraform_remote_state.networking_prod.outputs.public_subnets
    key_name         = data.terraform_remote_state.key_pair_global.outputs.key_name
}

module "bastion_gateway" {
    source           = "../../../../modules/services/bastion-gateway"

    vpc_id           = local.vpc_id
    image_id         = data.aws_ami.this.image_id
    instance_type    = var.instance_type
    min_size         = var.min_size
    max_size         = var.max_size
    key_name         = local.key_name

    environment      = var.environment

    vpc_zone_identifier  = local.public_subnets
}