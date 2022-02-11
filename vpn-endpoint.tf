resource "aws_ec2_client_vpn_endpoint" "client_vpn_endpoint" {
  description            = "${var.name}-Client-VPN"
  server_certificate_arn = aws_acm_certificate.server.arn
  client_cidr_block      = var.cidr
  split_tunnel           = var.is_split_tunnel
  dns_servers            = var.dns_servers

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.root.arn
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.vpn.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.vpn.name
  }

  tags = merge(
    var.tags,
    map(
      "Name", "${var.name}-Client-VPN",
      "EnvName", var.name
    )
  )
}

resource "aws_ec2_client_vpn_network_association" "client_vpn_network_association" {
  count                  = length(var.subnet_ids)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client_vpn_endpoint.id
  subnet_id              = element(var.subnet_ids, count.index)
  lifecycle {
    ignore_changes = [subnet_id]
  }

  security_groups = [aws_security_group.vpn-sg.id]
}

resource "null_resource" "authorize-client-vpn-ingress" {
  provisioner "local-exec" {
    command = "aws --region ${var.aws_region} ec2 authorize-client-vpn-ingress --client-vpn-endpoint-id ${aws_ec2_client_vpn_endpoint.client_vpn_endpoint.id} --target-network-cidr 0.0.0.0/0 --authorize-all-groups"
  }

  depends_on = [
    aws_ec2_client_vpn_endpoint.client_vpn_endpoint,
    aws_ec2_client_vpn_network_association.client_vpn_network_association
  ]
}

resource "null_resource" "authorize-client-internal-access" {
  provisioner "local-exec" {
    command = "aws --region ${var.aws_region} ec2 authorize-client-vpn-ingress --client-vpn-endpoint-id ${aws_ec2_client_vpn_endpoint.client_vpn_endpoint.id} --target-network-cidr ${var.vpc_cidr} --authorize-all-groups --description 'Access to internal network'"
  }

  depends_on = [
    aws_ec2_client_vpn_endpoint.client_vpn_endpoint,
    aws_ec2_client_vpn_network_association.client_vpn_network_association
  ]
}

resource "null_resource" "client_vpn_route_internet_access" {
  count     = length(var.subnet_ids)
  provisioner "local-exec" {
    when    = create
    command = "aws ec2 create-client-vpn-route --client-vpn-endpoint-id ${aws_ec2_client_vpn_endpoint.client_vpn_endpoint.id} --destination-cidr-block 0.0.0.0/0 --target-vpc-subnet-id ${var.subnet_ids[count.index]} --description Internet-Access --region ${var.aws_region}"
  }
}