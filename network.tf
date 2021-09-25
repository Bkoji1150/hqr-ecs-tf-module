# root/network.tf

module "networking" {
  source = "./networking"
  vpc-cidr = var.vpc-cidr
  pub-sub-cidr = [for pub_cidr in range(0, 225, 2) : cidrsubnet(var.vpc-cidr, 8, pub_cidr)]
  priv-sub-cidr = [for pub_cidr in range(1, 225, 2) : cidrsubnet(var.vpc-cidr, 8, pub_cidr)]
}

