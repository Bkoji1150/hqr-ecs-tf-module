#terraform {
#  backend "s3" {
#    bucket         = "tf-project-omega"
#    key            = "path/projectomega/haplet.tfstate"
#    region         = var.aws_region
#    dynamodb_table = "tf-project-omega"
#  }
#}
#provider "aws" {
#  profile = "default"
#  region  = var.aws_region
#}
#
#data "terraform_remote_state" operational_environment {
#  backend = "s3"
#  config {
#     bucket         = "tf-project-omega"
#    key            = format("env:/%s/haplet.tfstate", terraform.workspace)
#    region         = var.aws_region
#    dynamodb_table = "tf-project-omega"
#  }
#}
