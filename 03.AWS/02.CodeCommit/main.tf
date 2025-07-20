provider "aws" {
  region = "ap-northeast-1"  # Change this to your preferred AWS region
}

resource "aws_codecommit_repository" "my_repository" {
  repository_name = "repo-mujahed-sagemaker-pl"  # Change this to your desired repository name
  description     = "Sage Maker Pipeline CodeCommit repository"

  tags = {
    Environment = "dev"
    Team        = "DevOps"
  }
}
