variable pubsubnet-cidr {
  type = list(any)
  }
variable loadbalancer_sg {
  type = list(any)
}
variable vpc_id {
  type = string
}

variable health_check_path {
  type = string
}

variable port_lb {
  description = "The loadbal"
}

variable app_por_alb {
  type = number
  description = "Please provide the listener's port"
}