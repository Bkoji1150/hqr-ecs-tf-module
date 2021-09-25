variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "max_subnets" {
  type    = number
  default = 100
}

variable "az_count" {
  type    = number
  default = 2
}

variable "vpc-cidr" {
  type    = string
  default = "172.17.0.0/16"
}


variable "app_image" {
  description = "Image for containers"
  type        = map(any)
}

variable "app_port" {
  type        = number
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 8080

  validation {
    condition     = max(var.app_port) <= 9000 && min(var.app_port) > 0
    error_message = "The external port must be in the valid port range 0 - 9000."
  }
}

variable "app_por_alb" {
  description = "The port listen to by application load balancer...!"
  type        = number
  default     = 8080
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}


variable "health_check_path" {
  default = "/"
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 3
}


variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default     = "myEcsTaskExecutionRole"
}

variable port_lp {
  type = map(any)

  validation {
    condition = max(var.port_lp["dev"]) <= 9000 && min(var.port_lp["dev"]) > 1700
    error_message = "Sorry the port range you provided for dev isn't withing range, the ,max should be 9000 and the min should be 1700."
  }
  validation {
    condition = max(var.port_lp["prod"]) <= 10000 && min(var.port_lp["prod"]) > 8000
    error_message = "Sorry the port range you provided for dev isn't withing range, the ,max should be 9000 and the min should be 1700."
  }
}
