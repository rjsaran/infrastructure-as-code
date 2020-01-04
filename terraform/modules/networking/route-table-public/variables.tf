###################### AWS Public routing table variables ##########################
####### the variables in this file are passed in at environment level #######

# routing table variables
variable vpc_id     {}
variable cidr_block {}
variable gateway_id {}

# tag variable
variable environment {
    description = "Environment"
}