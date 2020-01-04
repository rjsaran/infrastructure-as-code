###################### AWS Bastion Gateway variables ##########################
####### the variables in this file are passed in at environment level #######

# Bastion Gateway variables
variable image_id        {}
variable vpc_id          {}
variable instance_type   {}
variable key_name        {}
variable max_size        {}
variable min_size        {}

variable vpc_zone_identifier {}

# tag variable
variable environment {
    description = "Environment"
}