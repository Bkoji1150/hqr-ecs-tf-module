variable "max_subnets" {
  type    = number
  default = 100
}

variable "vpc-cidr" {
  type    = string
}

variable "az_count" {
  type    = number
  default = 2
}

variable pub-sub-cidr {
  description = "provide your pub subnet cidr"
  type = list(any)
}

variable priv-sub-cidr {
  description = "Please private a cidr range for your private subnet"
  type = list(any)
}
