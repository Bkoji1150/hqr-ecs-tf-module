variable "aws_region" {
  type    = string
  default = "us-west-2"
}


variable "ecs-cluster" {
  type = string
}

#variable "template-file" {}

variable "app_image" {}

variable "app_port" {}

variable "fargate_cpu" {}
variable "fargate_memory" {}
variable aws_iam_role {
  type = string
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 3
}

variable security_group_for_ecs {}

variable private_sub_ids {}

variable loadbalancer_app_id {}
