terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

variable "ECR_IMAGE" {
  description = "ECR image ARN"
}

variable "DISCORD_TOKEN" {
  description = "Discord Token"
  sensitive   = true
}

provider "aws" {
  profile = "default"
  region  = "sa-east-1"
}

module "ecr" {
  source = "../modules/ecr"
}
module "task" {
  source = "../modules/task"

  ECR_IMAGE     = var.ECR_IMAGE
  DISCORD_TOKEN = var.DISCORD_TOKEN

  depends_on = [
    module.ecr
  ]
}

module "cluster" {
  source = "../modules/cluster"
}

module "service" {
  source = "../modules/service"

  depends_on = [
    module.task,
    module.cluster
  ]
}
