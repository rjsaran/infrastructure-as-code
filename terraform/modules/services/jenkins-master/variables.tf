###################### AWS Jenkins Master variables ##########################
####### the variables in this file are passed in at environment level #######

# Jenkins Master variables
variable vpc_id          {}
variable vpc_cidr_block  {}

variable image_id        {}
variable instance_type   {}
variable key_name        {}
variable public_subnets  {}

variable bastion_sg_id   {}

variable private_subnet_id {}

# tag variable
variable environment {
    description = "Environment"
}