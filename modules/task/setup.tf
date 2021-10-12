variable "ECR_IMAGE" {
  description = "ECR image ARN"
}

variable "DISCORD_TOKEN" {
  description = "Discord Token"
  sensitive   = true
}

variable "ECS_TASK_EXECUTION_ROLE" {
  description = "ECS Task execution role ARN"
  sensitive   = true
}

resource "aws_ecs_task_definition" "leokedin-task" {
  family = "leokedin-bot"

  task_role_arn      = var.ECS_TASK_EXECUTION_ROLE
  execution_role_arn = var.ECS_TASK_EXECUTION_ROLE

  network_mode = "awsvpc"

  requires_compatibilities = ["FARGATE"]

  memory = 512
  cpu    = 256

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
      "logConfiguration" : {
          "logDriver" : "awslogs",
          "options" : {
            "awslogs-group" : "/ecs/leokedin/bot",
            "awslogs-region" : "sa-east-1",
            "awslogs-stream-prefix" : "ecs"
          }
        },
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}