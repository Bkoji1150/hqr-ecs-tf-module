#root/ecs.tf

module "ecs" {
  source         = "./ecs"
  ecs-cluster    = "myapp-cluster"
  app_image      = lookup(var.app_image, terraform.workspace)
  app_port       = var.app_port
  fargate_cpu    = var.fargate_cpu
  fargate_memory = var.fargate_memory
  aws_region     = var.aws_region
  aws_iam_role = aws_iam_role.ecs_task_execution_role.arn
  security_group_for_ecs = [aws_security_group.ecs_tasks.id]
  private_sub_ids = module.networking.priv-cidr-sub
  loadbalancer_app_id = module.loadbalance.target_load_id
}
