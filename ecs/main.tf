resource "aws_ecs_cluster" "main" {
  name = var.ecs-cluster
}


data "template_file" "myapp" {
  template = file("myapp.json.tpl")

  vars = {
    app_image      = var.app_image #lookup(var.app_image, terraform.workspace)
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.aws_region
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "myapp-task"
  execution_role_arn       = var.aws_iam_role #.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.myapp.rendered
}

resource "aws_ecs_service" "main" {
  name            = "myapp-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.id
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = var.security_group_for_ecs
    subnets          = var.private_sub_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.loadbalancer_app_id
    container_name   = "myapp"
    container_port   = var.app_port
  }

# depends_on = var.depends
}
