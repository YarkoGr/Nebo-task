variable "aws_region" {}
variable "az_letter" {
  description = "List of availability zones letters."
  default     = ["a", "b"]
}

variable "private_subnet_netnum" {
  description = "List of 8-bit numbers of subnets of base_cidr_block that should be granted access."
  default     = [1, 2]
}

variable "public_subnet_netnum" {
  description = "List of 8-bit numbers of subnets of base_cidr_block that should be granted access."
  default     = [0, 1]
}