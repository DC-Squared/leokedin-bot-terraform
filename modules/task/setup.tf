variable "ECR_IMAGE" {
  description = "ECR image ARN"
}

variable "DISCORD_TOKEN" {
  description = "Discord Token"
  sensitive   = true
}

resource "aws_ecs_task_definition" "leokedin-task" {
  family = "leokedin-bot"

  container_definitions = jsonencode([
    {
      name      = "leokedin-bot"
      image     = "${var.ECR_IMAGE}"
      cpu       = 1
      memory    = 512
      essential = true
      "environment" : [
        { "name" : "DISCORD_TOKEN", "value" : "${var.DISCORD_TOKEN}" }
      ],
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}