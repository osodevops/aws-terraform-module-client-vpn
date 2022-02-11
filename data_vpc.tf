data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet_ids" "private" {
  vpc_id     = "${data.aws_vpc.this.id}"
  tags = {
    Name = var.private_subnet_name_filter
  }
}