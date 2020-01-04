# TODO Use Mgmt VPC 
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

data "terraform_remote_state" "jenkins_master_mgmt" {
    backend = "s3"

    config = {
        bucket  = "terraform-state-2020-01-01"
        region  = "ap-southeast-1"
        key     = "mgmt/services/jenkins-master/terraform.tfstate"
    }
}

data "aws_ami" "this" {
    most_recent = true
    owners      = ["self"]

    filter {
        name   = "name"
        
        values = ["packer-linux-docker-swarm-*"]
    }
}

locals {
    vpc_id             = data.terraform_remote_state.networking_prod.outputs.vpc_id
    vpc_cidr_block     = data.terraform_remote_state.networking_prod.outputs.vpc_cidr_block
    public_subnets     = data.terraform_remote_state.networking_prod.outputs.public_subnets
    private_subnets    = data.terraform_remote_state.networking_prod.outputs.private_subnets

    bastion_sg_id   = data.terraform_remote_state.bastion_mgmt.outputs.security_group_id
    jenkins_master_sg_id = data.terraform_remote_state.jenkins_master_mgmt.outputs.security_group_id

    key_name         = data.terraform_remote_state.key_pair_global.outputs.key_name
}

module "docker_swarm" {
    source           = "../../../../modules/services/docker-swarm"

    vpc_id           = local.vpc_id
    vpc_cidr_block   = local.vpc_cidr_block

    image_id         = data.aws_ami.this.image_id
    key_name         = local.key_name
    environment      = var.environment

    manager_instance_type   = var.manager_instance_type
    min_managers            = var.min_managers
    max_managers            = var.max_managers

    worker_instance_type   = var.worker_instance_type
    min_workers            = var.min_workers
    max_workers            = var.max_workers

    s3_bucket_name     = var.s3_bucket_name

    public_subnets           = local.public_subnets
    private_subnets          = local.private_subnets
    bastion_sg_id            = local.bastion_sg_id
    jenkins_master_sg_id     = local.jenkins_master_sg_id
}