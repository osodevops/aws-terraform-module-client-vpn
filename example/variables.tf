variable "name" {
  description = "Name prefix for the resources of this stack"
}

variable "cidr" {
  description = "Network CIDR to use for clients"
}

variable "organization_name" {
  description = "Name of organization to use in private certificate"
  default     = "ACME, Inc"
}

variable "logs_retention" {
  default     = 365
  description = "Retention in days for CloudWatch Log Group"
}

variable "common_tags" {
  type        = map
  default     = {}
  description = "Common tags to attach to resources"
}

variable "vpc_name" {
  description = "Set the VPC name"
}

variable "is_split_tunnel" {
  default = false
}

variable "dns_servers" {
  default = ["8.8.8.8"]
  type    = list
}

variable "aws_region" {
  default = "eu-west-2"
}


variable "detected_jz_cert_name" {
  type    = string
  description = "Tha name that the certificate is for."
  default = "jz@detected.app"
}

variable "private_subnet_name_filter" {
  type = string
  description = "The tag on the private subnets."
}