################### AWS Auto Scaling & Launch Configuration resource variables ######################
### the variables in this file are passed in at environment level ###

# Launch Configuration variables
variable "image_id" {
  description = "The EC2 image ID to launch"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "The size of instance to launch"
  type        = string
  default     = ""
}

variable "iam_instance_profile" {
  description = "The IAM instance profile to associate with launched instances"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "The key name that should be used for the instance"
  type        = string
  default     = ""
}

variable "security_groups" {
    description = "A list of security group IDs to assign to the launch configuration"
    type        = list(string)
    default     = []
}


variable "user_data" {
  description = "The user data to provide when launching the instance"
  type        = string
  default     = " "
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance"
  type        = list(map(string))	
  default     = []
}


# Auto Scaling variables
variable "name" {
    description = "Name of the auto scale group"
    type        = string
}

variable "max_size" {
    description = "The maximum size of the auto scale group"
    type        = string
}

variable "min_size" {
    description = "The minimum size of the auto scale group"
    type        = string
}

variable "vpc_zone_identifier" {
    description = "A list of subnet IDs to launch resources in"
    type        = list(string)
}

variable "load_balancers" {
	description = "A list of elastic load balancer names to add to the autoscaling group names"
	type        = list(string)
	default     = []
}

# tag variable
variable environment {
    description = "Environment"
}