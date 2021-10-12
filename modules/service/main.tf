variable "TASK_DEFINITION" {
  description = "TAsk Definition ARN"
}

variable "CLUSTER" {
  description = "Cluster ARN"
}

resource "aws_ecs_service" "leokedin-service" {
  name = "leokedin-bot"

  cluster         = var.CLUSTER
  task_definition = var.TASK_DEFINITION

  desired_count = 1
}