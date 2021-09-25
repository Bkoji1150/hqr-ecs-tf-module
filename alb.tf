# alb.tf

module loadbalance {
  source = "./loadbalancer"
  pubsubnet-cidr = module.networking.pub-cidr-sub
  vpc_id = module.networking.vpc_id
  loadbalancer_sg = [aws_security_group.lb.id]
  health_check_path = var.health_check_path
  port_lb = lookup(var.port_lp, terraform.workspace)
  app_por_alb = var.app_por_alb
}
