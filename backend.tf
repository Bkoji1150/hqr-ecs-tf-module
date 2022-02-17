terraform {
  backend "s3" {
    bucket         = "tf-project-omega"
    key            = "haplet.tfstate"
    encrypt = true
    region         = "us-west-2"
    
  }
}

# data "terraform_remote_state" operational_environment {
#   backend = "s3"
#   config = {
#      bucket         = "tf-project-omega"
#     key            = format("env:/%s/haplet.tfstate", lower(terraform.workspace))
#     dynamodb_table = "tf-project-omega"
#     region = "us-west-2"
#   }
# }
