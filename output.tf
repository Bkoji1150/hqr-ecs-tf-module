output "template-file" {
  value = data.template_file.myapp.rendered
}

output "ecs-cluter" {
  value = aws_ecs_cluster.main.id
}

output aws_task {
  value = aws_ecs_task_definition.app.id
}

output ecs_service {
  value = aws_ecs_service.main.id
}
