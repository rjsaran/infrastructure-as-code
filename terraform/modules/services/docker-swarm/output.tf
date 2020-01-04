output "elb_dns_name" {
    value = module.docker_swarm_visualizer_elb.this_elb_dns_name
}