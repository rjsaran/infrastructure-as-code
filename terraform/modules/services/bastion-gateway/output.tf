# outputs produced at the end of a terraform apply:

output "bastion_launch_configuration_id" {
    description = "The ID of the launch configuration"
    value       = module.bastion_gateway_asg.this_launch_configuration_id
}

output "bastion_launch_configuration_name" {
    description = "The name of the launch configuration"
    value       = module.bastion_gateway_asg.this_launch_configuration_name
}

output "bastion_autoscaling_group_id" {
    description = "The autoscaling group id"
    value       = module.bastion_gateway_asg.this_autoscaling_group_id
}

output "bastion_autoscaling_group_name" {
    description = "The autoscaling group name"
    value       = module.bastion_gateway_asg.this_autoscaling_group_name
}

output "bastion_security_group_id" {
    description = "The Security Group"
    value       = module.bastion_gateway_sg.this_security_group_id
}