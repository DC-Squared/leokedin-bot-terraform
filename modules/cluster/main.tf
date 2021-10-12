resource "aws_ecs_cluster" "leokedin-ecs" {
  name = "leokedin-bot"

  capacity_providers = [
    "FARGATE_SPOT"
  ]
  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}
