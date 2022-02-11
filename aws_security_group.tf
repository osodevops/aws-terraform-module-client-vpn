resource "aws_security_group" "vpn-sg" {
  vpc_id      = data.aws_vpc.this.id
  name        = "AWS-${var.name}-VPN-SG"
  description = "AWS VPN Client - Managed by Terraform"

  tags = merge(var.tags,
    {
      "Name" = "AWS-${var.name}-VPN-SG"
    }
  )
}

resource "aws_security_group_rule" "detected-sg-ingress-vpc" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = aws_security_group.vpn-sg.id
}

resource "aws_security_group_rule" "vpn-sg-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vpn-sg.id
}