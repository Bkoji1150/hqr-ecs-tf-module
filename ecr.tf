#resource "aws_ecr_repository" "main" {
#  name                 = "haplet-registory"
#  image_tag_mutability = "MUTABLE"
#   }
#
#
#resource "aws_ecr_repository_policy" "foopolicy" {
#  repository = aws_ecr_repository.main.name
#
#  policy = file("ecr-policy.json.tpl")
#}

resource "aws_ecr_repository" "demo-repository" {
  name                 = "haplet-registory"
  image_tag_mutability = "IMMUTABLE"
}

resource "aws_ecr_repository_policy" "demo-repo-policy" {
  repository = aws_ecr_repository.demo-repository.name
  policy     = <<EOF
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "adds full ecr access to the demo repository",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
  }
  EOF
}