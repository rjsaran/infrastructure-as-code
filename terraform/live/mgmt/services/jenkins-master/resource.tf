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

data "terraform_remote_state" "bastion_mgmt" {
    backend = "s3"

    config = {
        bucket  = "terraform-state-2020-01-01"
        region  = "ap-southeast-1"
        key     = "mgmt/services/bastion-gateway/terraform.tfstate"
    }
}

data "aws_ami" "jenkins_master" {
    most_recent = true
    owners      = ["self"]

    filter {
        name   = "name"
        
        values = ["packer-linux-jenkins-master-*"]
    }
}

locals {
    vpc_id             = data.terraform_remote_state.networking_prod.outputs.vpc_id
    vpc_cidr_block     = data.terraform_remote_state.networking_prod.outputs.vpc_cidr_block
    public_subnets     = data.terraform_remote_state.networking_prod.outputs.public_subnets
    private_subnet_id  = data.terraform_remote_state.networking_prod.outputs.private_subnets[0]

    bastion_sg_id   = data.terraform_remote_state.bastion_mgmt.outputs.security_group_id

    key_name         = data.terraform_remote_state.key_pair_global.outputs.key_name
}

module "jenkins_master" {
    source           = "../../../../modules/services/jenkins-master"

    vpc_id           = local.vpc_id
    vpc_cidr_block   = local.vpc_cidr_block

    image_id         = data.aws_ami.jenkins_master.image_id
    instance_type    = var.instance_type
    key_name         = local.key_name
    environment      = "mgmt"

    public_subnets    = local.public_subnets
    private_subnet_id = local.private_subnet_id
    bastion_sg_id     = local.bastion_sg_id
}