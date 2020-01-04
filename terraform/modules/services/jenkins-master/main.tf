# Jenkins Master ELB SG
module "jenkins_master_elb_sg" {
    source       = "terraform-aws-modules/security-group/aws"

    vpc_id      = var.vpc_id

    name        = "jenkins_master_elb_sg"
    description = "Allow http traffic"

    ingress_with_cidr_blocks = [
        {
            from_port   = 80
            to_port     = 80
            protocol    = "tcp"
            cidr_blocks = "0.0.0.0/0"
            description = "Allow HTTP traffic from all"
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
        Name        = "jenkins_master_elb_sg"
        Environment = var.environment
        Tool        = "Terraform"
    }
}

module "jenkins_master_sg" {
    source       = "terraform-aws-modules/security-group/aws"

    vpc_id       = var.vpc_id

    name         = "jenkins_master_sg"
    description  = "Allow traffic on port 8080 and enable SSH"

    ingress_with_cidr_blocks = [
        {
            from_port   = 8080
            to_port     = 8080
            protocol    = "tcp"
            cidr_blocks = var.vpc_cidr_block
        }
    ]

    ingress_with_source_security_group_id = [
        {
            from_port   = 8080
            to_port     = 8080
            protocol    = "tcp"
            source_security_group_id = module.jenkins_master_elb_sg.this_security_group_id
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
        Name        = "jenkins_master_sg"
        Environment = var.environment
        Tool        = "Terraform"
    }
}

# Jenkins Master Ec2 Instance
module "jenkins_master_ec2_instance" {
    source              = "terraform-aws-modules/ec2-instance/aws"

    name                = "jenkins_master"
    ami                 = var.image_id
    instance_type       = var.instance_type
    key_name            = var.key_name
    subnet_id           = var.private_subnet_id

    vpc_security_group_ids = [module.jenkins_master_sg.this_security_group_id]

    root_block_device = [
        {
            volume_type           = "gp2"
            volume_size           = 30
            delete_on_termination = false
        }
    ]

    tags = {
        Name           = "jenkins_master"
        Environment    = var.environment
        Tool           = "Terraform"
    }
}

# Jenkins Master ELB
module "jenkins_master_elb" {
    source              = "../../networking/classic-load-balancer"

    name                = "jenkins-master-elb"

    subnets             = var.public_subnets

    security_groups     = [module.jenkins_master_elb_sg.this_security_group_id]
    instances           = flatten([module.jenkins_master_ec2_instance.id])

    environment         =  var.environment

    listener  = [
        {
            lb_port            = 80
            lb_protocol        = "http"
            instance_port      = 8080
            instance_protocol  = "http"
        }
    ]

    health_check = {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        target              = "TCP:8080"
        interval            = 5
    }
}