###################### AWS Jenkins Slave variables ##########################
####### the variables in this file are passed in at environment level #######

# Jenkins Slave variables
variable vpc_id          {}
variable image_id        {}
variable instance_type   {}
variable key_name        {}

variable bastion_sg_id   {}

variable max_size        {}
variable min_size        {}

variable vpc_zone_identifier {}

variable jenkins_master {
    description = "Jenkins Master information"
    type        = map(string)
    default     = {}
}

# tag variable
variable environment {
    description = "Environment"
}