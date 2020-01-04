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

data "terraform_remote_state" "jenkins_master_mgmt" {
    backend = "s3"

    config = {
        bucket  = "terraform-state-2020-01-01"
        region  = "ap-southeast-1"
        key     = "mgmt/services/jenkins-master/terraform.tfstate"
    }
}

data "aws_ami" "jenkins_slave" {
    most_recent = true
    owners      = ["self"]

    filter {
        name   = "name"
        
        values = ["packer-linux-jenkins-slave-*"]
    }
}

locals {
    vpc_id             = data.terraform_remote_state.networking_prod.outputs.vpc_id
    private_subnets     = data.terraform_remote_state.networking_prod.outputs.private_subnets

    bastion_sg_id   = data.terraform_remote_state.bastion_mgmt.outputs.security_group_id

    jenkins_master_sg_id = data.terraform_remote_state.jenkins_master_mgmt.outputs.security_group_id
    jenkins_master_ip    = data.terraform_remote_state.jenkins_master_mgmt.outputs.master_private_ip

    key_name         = data.terraform_remote_state.key_pair_global.outputs.key_name
}

module "jenkins_slave" {
    source           = "../../../../modules/services/jenkins-slave"

    vpc_id           = local.vpc_id

    image_id         = data.aws_ami.jenkins_slave.image_id
    instance_type    = var.instance_type
    key_name         = local.key_name
    environment      = var.environment

    min_size         = var.min_size
    max_size         = var.max_size

    bastion_sg_id    = local.bastion_sg_id

    vpc_zone_identifier = local.private_subnets

    jenkins_master = {
        sg_id     = local.jenkins_master_sg_id
        ip        = local.jenkins_master_ip
        proto     = "http"
        port      = 8080
        username  = var.master_username
        password  = var.master_password
    
        slave_credentials_id = var.slave_credentials_id
    }
}