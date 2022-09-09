
variable "allow_ports" {
  description = "List of Ports to open for server"
  type        = list(any)
  default     = ["80", "443", "22"]
}

variable "env" {
  default = "development"
}

variable "public_subnet_cidrs" {
  description = "List of private subnets"
  type        = list(string)
  default = [
    "10.0.8.0/24",
    "10.0.9.0/24",
    "10.0.10.0/24",
  ]
}

variable "private_subnets" {
  description = "List of private subnets"
  type        = list(string)
  default = [
    "10.0.11.0/24",
    "10.0.12.0/24",
    "10.0.13.0/24"
  ]
}

variable "vpc_cidr_blocks" {}

variable "availability_zones" {}
