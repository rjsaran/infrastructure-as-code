###################### AWS Elastic Container Registry variables ##########################
### the variables in this file are passed in at environment level ####

# ECR variables
variable name {
    description = "Repository Name"
}

variable image_tag_mutability {
    description = "Image Tag Mutability"
    default     = "MUTABLE"
}

variable scan_on_push {
    description = "Scan on push"
    default      = true
}

# tag variable
variable environment {
    description = "Environment"
}