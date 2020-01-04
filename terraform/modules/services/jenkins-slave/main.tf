# Jenkins Slave SG
module "jenkins_slave_sg" {
    source       = "terraform-aws-modules/security-group/aws"

    vpc_id      = var.vpc_id

    name        = "jenkins_slave_sg"
    description = "Allow traffic on port 22 from Jenkins Master SG"

    ingress_with_source_security_group_id = [
        {
            from_port   = 22
            to_port     = 22
            protocol    = "tcp"
            source_security_group_id = var.jenkins_master.sg_id
        },
        {
            from_port   = 22
            to_port     = 22
            protocol    = "tcp"
            source_security_group_id = var.bastion_sg_id
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
        Name        = "jenkins_slave_sg"
        Environment = var.environment
        Tool        = "Terraform"
    }
}

# Resource Template: Jenkins Slaves
data "template_file" "this" {
    template = file("${path.module}/templates/join_cluster.tpl")

    vars = {
        jenkins_url            = "${var.jenkins_master.proto}://${var.jenkins_master.ip}:${var.jenkins_master.port}"
        jenkins_username       = var.jenkins_master.username
        jenkins_password       = var.jenkins_master.password
        jenkins_credentials_id = var.jenkins_master.slave_credentials_id
    }
}

# Jenkins Slave Auto Scaling Group
module "jenkins_slave_asg" {
    source              = "../../networking/auto-scaling-group"

    image_id            = var.image_id
    instance_type       = var.instance_type
    key_name            = var.key_name
    security_groups     = [module.jenkins_slave_sg.this_security_group_id]

    user_data           = data.template_file.this.rendered

    min_size            = var.min_size
    max_size            = var.max_size

    vpc_zone_identifier = var.vpc_zone_identifier

    root_block_device = [
        {
            volume_type           = "gp2"
            volume_size           = 30
            delete_on_termination = false
        }
    ]

    name                = "jenkins_slave_asg"
    environment         = var.environment
}