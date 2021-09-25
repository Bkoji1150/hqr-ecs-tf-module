# outputs.tf

output "alb_hostname" {
  value = module.loadbalance.dns_name
}
