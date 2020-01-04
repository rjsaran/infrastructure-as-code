# ELB DNS Name
output "elb_dns_name" {
    value = module.docker_swarm.elb_dns_name
}