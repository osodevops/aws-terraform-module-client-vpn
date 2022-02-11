module "vpn-aws-client" {
  source                     = "../"
  name                       = var.name
  cidr                       = var.cidr
  organization_name          = var.organization_name
  logs_retention             = var.logs_retention
  tags                       = var.common_tags
  vpc_name                   = var.vpc_name
  dns_servers                = var.dns_servers
  aws_region                 = var.aws_region
  private_subnet_name_filter = var.private_subnet_name_filter
}