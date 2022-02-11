data "aws_vpc" "vpn" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}