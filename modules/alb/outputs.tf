output "alb_arn" {
  value = aws_lb.main[*].arn
}

output "tg_arn" {
  value = aws_alb_target_group.main.arn
}
