# outputs produced at the end of a terraform apply:

output "master_private_ip" {
    description  = "The IP of master ec2 instance"
    value        = module.jenkins_master_ec2_instance.private_ip[0]
}

output "security_group_id" {
    description = "The Security Group ID"
    value       = module.jenkins_master_sg.this_security_group_id
}

output "master_elb_dns" {
    description = "The ELB DNS Name"
    value      = module.jenkins_master_elb.this_elb_dns_name
}