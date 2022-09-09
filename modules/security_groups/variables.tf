variable "env" {
  default = "development"
  type    = string
}

variable "container_port" {
  default = "4000"
  type    = string
}

variable "project" {
  description = "project name"
  default     = "PACMAN-XXX"
  type        = string
}

variable "vpc_id" {
  default = "dev"
}
