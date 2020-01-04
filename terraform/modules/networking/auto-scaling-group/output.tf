# outputs produced at the end of a terraform apply:

output "this_launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = aws_launch_configuration.this.id
}

output "this_launch_configuration_name" {
  description = "The name of the launch configuration"
  value       = aws_launch_configuration.this.name
}

output "this_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = aws_autoscaling_group.this.id
}

output "this_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = aws_autoscaling_group.this.name
}