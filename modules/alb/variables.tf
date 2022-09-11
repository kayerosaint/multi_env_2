variable "project" {
  description = "project name"
  default     = "PACMAN-XXX"
  type        = string
}

variable "env" {
  description = "development"
  type        = string
}

variable "health_check_path" {
  default = "/health_check"
}

variable "vpc_id" {}

variable "public_subnets" {}

variable "alb_sg" {}
