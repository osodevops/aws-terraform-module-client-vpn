name                       = "Example"
cidr                       = "192.168.0.0/22"
vpc_name                   = "example-dev"
aws_region                 = "eu-west-2"
dns_servers                = ["8.8.8.8"]
organization_name          = "ExampleOrganization"
logs_retention             = 365

private_subnet_name_filter = "example-dev-Private-*"

common_tags={
    AccountType=           "IAC"
    Application=           "aws-vpn"
    CostCode=              "VPN"
    Environment=           "Staging"
    SquadName=             "example"
    TFVersion=             "1.14"
    TFState=               "aws-vpn-client"
    Deployment=            "Terraform"
}