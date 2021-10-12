resource "aws_ecs_cluster" "leokedin-ecs" {
  name = "leokedin-bot"

  capacity_providers = [
    "FARGATE"
  ]
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
