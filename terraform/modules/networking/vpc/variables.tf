################### AWS VPC resource variables ######################
### the variables in this file are passed in at environment level ###

# vpc variables
variable "cidr_block" {
    description = "VPC CIDR block"
    default     = "10.0.0.0/16"
}

variable "name" {
    description = "VPC name"
    default     = "default"
}

# tag variable
variable environment {
    description = "Environment"
}
