#==========================local docker vars=========================#
/*
variable "host" {
  description = "instance host"
  type        = string
}

variable "image" {
  description = "dockerhub image"
  type        = string
}
*/
#==========================local docker vars=========================#

variable "project" {
  description = "project name"
  default     = "PACMAN-XXX"
  type        = string
}

variable "env" {
  description = "development"
  type        = string
}

variable "task_cpu" {
  description = "cpu usage"
  type        = string
}

variable "task_memory" {
  description = "memory usage"
  type        = string
}

variable "image" {
  description = "ecs image"
  type        = string
}

variable "container_port" {
  #default = "4000"
  type = number
}


#=============ALB==============#
variable "alb_sg" {}

variable "vpc_id" {}

variable "public_subnets" {}

variable "ecs_tasks" {}
