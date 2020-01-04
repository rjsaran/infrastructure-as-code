###################### AWS Docker Swarm Cluster variables ##########################
####### the variables in this file are passed in at environment level #######

# Docker Swarm Cluster variables
variable vpc_id          {}
variable vpc_cidr_block  {}

variable image_id        {}
variable key_name        {}

variable manager_instance_type   {}
variable min_managers        {}
variable max_managers        {}

variable worker_instance_type   {}
variable min_workers        {}
variable max_workers        {}

variable bastion_sg_id        {}
variable jenkins_master_sg_id {}

variable private_subnets  {}
variable public_subnets   {}

variable "swarm_name" {
    description = "Docker Swarm Cluster Name"
    default     = "docker_swarm_cluster"
}

variable "s3_bucket_name" {
    description = "S3 Bucket for swarm discovery"
}

# tag variable
variable environment {
    description = "Environment"
}