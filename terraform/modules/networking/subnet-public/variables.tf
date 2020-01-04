################## AWS public subnet variables ######################
### the variables in this file are passed in at environment level ###

# public subnet variables
variable vpc_id            {}
variable subnets           {}
variable route_table_id    {}

# tag variable
variable environment {
    description = "Environment"
}