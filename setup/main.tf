terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

variable "NETWORK" {
  description = "Network definition"
}

variable "ECR_IMAGE" {
  description = "ECR image ARN"
}

variable "DISCORD_TOKEN" {
  description = "Discord Token"
  sensitive   = true
}

variable "TWITCH_CLIENT_ID" {
  description = "Twitch Client ID"
  sensitive   = true
}

variable "TWITCH_CLIENT_SECRET" {
  description = "Twitch Client Secret"
  sensitive   = true
}

variable "ECS_TASK_EXECUTION_ROLE" {
  description = "ECS Task execution role ARN"
  sensitive   = true
}


provider "aws" {
  profile = "default"
  region  = "sa-east-1"
}

module "cloudwatch" {
  source = "../modules/cloudwatch"
}
module "ecr" {
  source = "../modules/ecr"
}
module "task" {
  source = "../modules/task"

  ECR_IMAGE               = var.ECR_IMAGE
  DISCORD_TOKEN           = var.DISCORD_TOKEN
  ECS_TASK_EXECUTION_ROLE = var.ECS_TASK_EXECUTION_ROLE

  depends_on = [
    module.ecr,
    module.cloudwatch
  ]
}

module "cluster" {
  source = "../modules/cluster"
}

module "service" {
  source = "../modules/service"

  TASK_DEFINITION = module.task.arn
  CLUSTER         = module.cluster.arn
  NETWORK         = var.NETWORK

  depends_on = [
    module.task,
    module.cluster
  ]
}
