resource "aws_ecs_cluster" "leokedin-ecs" {
  name = "leokedin-bot"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}