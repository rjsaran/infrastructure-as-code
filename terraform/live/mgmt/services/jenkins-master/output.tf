# outputs produced at the end of a terraform apply:

output "master_private_ip" {
    description  = "The IP of master ec2 instance"
    value        = module.jenkins_master.master_private_ip
}

output "security_group_id" {
    description = "The Security Group ID"
    value       = module.jenkins_master.security_group_id
}

output "master_elb_dns" {
    description = "The ELB DNS Name"
    value      = module.jenkins_master.master_elb_dns
}