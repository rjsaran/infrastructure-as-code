###################### AWS subnet variables ##########################
### the variables in this file are passed in at environment level ####

# subnet variables
variable vpc_id                  {}
variable subnets                 {}
variable map_public_ip_on_launch {}
variable purpose                 {}

variable route_table_id          {}

# tag variable
variable environment {
    description = "Environment"
}