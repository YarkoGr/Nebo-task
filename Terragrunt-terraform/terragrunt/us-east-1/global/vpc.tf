module "ypasko_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = local.vpc_name
  cidr = local.vpc_cidr

  azs = [
    for az in var.az_letter :
    join("", [var.aws_region, az])
  ]
  private_subnets = [
    for num in var.private_subnet_netnum :
    cidrsubnet(local.vpc_cidr, 4, num)
  ]
  public_subnets = [
    for num in var.public_subnet_netnum :
    cidrsubnet(local.vpc_cidr, 6, num)
  ]

  enable_nat_gateway      = true
  single_nat_gateway      = true

  public_dedicated_network_acl   = true
  public_inbound_acl_rules       = concat(local.network_acls["default_inbound"], local.network_acls["public_inbound"])
  public_outbound_acl_rules      = concat(local.network_acls["default_outbound"], local.network_acls["public_outbound"])
  
  private_dedicated_network_acl   = true
  private_inbound_acl_rules       = concat(local.network_acls["default_inbound"], local.network_acls["private_inbound"])
  private_outbound_acl_rules      = concat(local.network_acls["default_outbound"], local.network_acls["private_outbound"])

  public_subnet_suffix    = local.public_subnet_suffix

  public_subnet_tags      = local.public_subnet_tags
  private_subnet_tags     = local.private_subnet_tags
  vpc_tags                = local.vpc_tags
}