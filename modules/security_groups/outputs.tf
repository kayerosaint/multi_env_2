output "alb_sg" {
  value = aws_security_group.alb_sg.id
}

output "ecs_tasks" {
  value = aws_security_group.ecs_tasks.id
}

output "vpc_id" {
  value = try(data.aws_vpc.dev_vpc[*].id, "")
}

output "vpc_cidr_blocks" {
  value = try(data.aws_vpc.dev_vpc[*].cidr_block, "")
}
