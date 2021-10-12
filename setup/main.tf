terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile    = "default"
  region     = "sa-east-1"
}

module "task" {
  source  = "../modules/task"
}

module "cluster" {
  source = "../modules/cluster"
}

module "service" {
  source     = "../modules/service"

  depends_on = [
    module.task,
    module.cluster
  ]
}

