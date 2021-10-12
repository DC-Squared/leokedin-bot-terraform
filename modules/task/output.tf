output "config" {
  value = {
    arn = aws_ecs_task_definition.leokedin-task.arn
  }

  description = "Task definition ARN"
}
