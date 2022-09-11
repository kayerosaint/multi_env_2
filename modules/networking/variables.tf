
variable "allow_ports" {
  description = "List of Ports to open for server"
  type        = list(any)
  default     = ["80", "443", "22"]
}

variable "env" {
  default = "development"
}

variable "public_subnets" {
  description = "List of private subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnets"
  type        = list(string)
}

variable "vpc_cidr_blocks" {}

variable "availability_zones" {}
