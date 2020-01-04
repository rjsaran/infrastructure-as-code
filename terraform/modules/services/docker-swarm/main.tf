# Docker Cluster Visulaizer SG
module "docker_swarm_visulazier_elb_sg" {
    source       = "terraform-aws-modules/security-group/aws"

    vpc_id      = var.vpc_id

    name        = "docker_swarm_visulazier_elb_sg"
    description = "Allow traffic on http"

    ingress_with_cidr_blocks = [
        {
            from_port   = 80
            to_port     = 80
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
        Name        = "docker_swarm_visulazier_elb_sg"
        Environment = var.environment
        Tool        = "Terraform"
    }
}

# Docker Swarm SG
module "docker_swarm_sg" {
    source       = "terraform-aws-modules/security-group/aws"

    vpc_id      = var.vpc_id

    name        = "docker_swarm_sg"
    description = "Allow TCP: 2377,7946,2375,22,8080 UDP: 7946,4789"

    ingress_with_cidr_blocks = [
        {
            from_port   = 2377
            to_port     = 2377
            protocol    = "tcp"
            cidr_blocks = var.vpc_cidr_block
        },
        {
            from_port   = 2375
            to_port     = 2375
            protocol    = "tcp"
            cidr_blocks = var.vpc_cidr_block
        },
        {
            from_port   = 7946
            to_port     = 7946
            protocol    = "tcp"
            cidr_blocks = var.vpc_cidr_block
        },
         {
            from_port   = 7946
            to_port     = 7946
            protocol    = "udp"
            cidr_blocks = var.vpc_cidr_block
        },
        {
            from_port   = 4789
            to_port     = 4789
            protocol    = "udp"
            cidr_blocks = var.vpc_cidr_block
        }
    ]

    ingress_with_source_security_group_id = [
        {
            from_port   = 8080
            to_port     = 8080
            protocol    = "tcp"
            source_security_group_id = module.docker_swarm_visulazier_elb_sg.this_security_group_id
        },
        {
            from_port   = 22
            to_port     = 22
            protocol    = "tcp"
            source_security_group_id = var.bastion_sg_id
        },
        {
            from_port   = 22
            to_port     = 22
            protocol    = "tcp"
            source_security_group_id = var.jenkins_master_sg_id
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
        Name        = "docker_swarm_sg"
        Environment = var.environment
        Tool        = "Terraform"
    }
}

# Create S3 Bucket for Swarm Discovery
resource "aws_s3_bucket" "this" {
    bucket = var.s3_bucket_name

    acl    = "private"

    versioning {
        enabled = true
    }
}

resource "aws_iam_role" "this" {
    name = "DockerSwarmDiscoveryBucketRole"
    path = "/"

    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

# IAM Instance Profile for Docker discovery bucket acces
resource "aws_iam_instance_profile" "this" {
    name = "DockerSwarmDiscoveryBucketAccess"
    role = aws_iam_role.this.name
}

resource "aws_iam_role_policy" "policy" {
    name = "DockerSwarmDiscoveryBucketPolicy"
    role = aws_iam_role.this.id

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::${var.s3_bucket_name}/*",
                "Action": [
                    "s3:GetObject",
                    "s3:PutObject",
                    "s3:ListObjects"
                ]
            },
        {
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::${var.s3_bucket_name}",
            "Action": [
                "s3:ListBucket"
            ]
        }
    ]
}
EOF
}

# Resource Template: Swarm managers
data "template_file" "user_data_manager" {
    template = file("${path.module}/templates/setup_cluster.tpl")

    vars = {
        swarm_discovery_bucket = var.s3_bucket_name
        swarm_name             = var.swarm_name
        swarm_role             = "manager"
    }
}

# Resource Template: Swarm workers
data "template_file" "user_data_worker" {
    template = file("${path.module}/templates/setup_cluster.tpl")

    vars = {
        swarm_discovery_bucket = var.s3_bucket_name
        swarm_name             = var.swarm_name
        swarm_role             = "worker"
    }
}

# ELB: Docker Swarm Cluster Visualizer
module "docker_swarm_visualizer_elb" {
    source              = "../../networking/classic-load-balancer"

    name                = "docker-swarm-visualizer-elb"

    subnets             = var.public_subnets

    security_groups     = [module.docker_swarm_visulazier_elb_sg.this_security_group_id]

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
        target              = "HTTP:8080/"
        interval            = 5
    }
}

# Auto Scaling Group: Swarm managers
module "docker_swarm_manager_asg" {
    source              = "../../networking/auto-scaling-group"

    image_id            = var.image_id

    instance_type       = var.manager_instance_type
    key_name            = var.key_name
    min_size            = var.min_managers
    max_size            = var.max_managers

    load_balancers      = [module.docker_swarm_visualizer_elb.this_elb_name]
    security_groups     = [module.docker_swarm_sg.this_security_group_id]

    user_data           = data.template_file.user_data_manager.rendered

    vpc_zone_identifier = var.private_subnets

    iam_instance_profile = aws_iam_instance_profile.this.arn

    name                = "docker_swarm_manager"
    environment         = var.environment
}

# Auto Scaling Group: Swarm workers
module "docker_swarm_worker_asg" {
    source              = "../../networking/auto-scaling-group"

    image_id            = var.image_id

    instance_type       = var.worker_instance_type
    key_name            = var.key_name
    min_size            = var.min_workers
    max_size            = var.max_workers

    security_groups     = [module.docker_swarm_sg.this_security_group_id]

    user_data           = data.template_file.user_data_worker.rendered

    vpc_zone_identifier = var.private_subnets

    iam_instance_profile = aws_iam_instance_profile.this.arn

    name                = "docker_swarm_worker"
    environment         = var.environment
}