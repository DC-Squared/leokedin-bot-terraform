variable "TASK_DEFINITION" {
  description = "TAsk Definition ARN"
}

variable "CLUSTER" {
  description = "Cluster ARN"
}

variable "NETWORK" {
  description = "Network definition"
}

resource "aws_ecs_service" "leokedin-service" {
  name = "leokedin-bot"

  cluster         = var.CLUSTER
  task_definition = var.TASK_DEFINITION

  desired_count = 1

  deployment_controller {
    type = "ECS"
  }

  launch_type = "FARGATE"

  network_configuration {
    assign_public_ip = true
    security_groups  = var.NETWORK.sg
    subnets          = var.NETWORK.subnets
  }
}
