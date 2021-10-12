resource "aws_ecr_repository" "leokedin-bot" {
  name                 = "leokedin-bot"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}