# module "ypasko_sg" {
#   source  = "terraform-aws-modules/security-group/aws"
#   version = "4.9.0"

#   name        = "ypasko-sg-bastion"
#   description = "ypasko SG for ssh connection bastion"
#   vpc_id      = module.ypasko_vpc.vpc_id
#   # ingress_cidr_blocks = ["${local.vpc_cidr}"]
#   # ingress_rules       = ["ssh-tcp"]

#   ingress_with_cidr_blocks = [
#     {
#       from_port   = 22
#       to_port     = 22
#       protocol    = 6
#       description = "SSH"
#       cidr_blocks = "0.0.0.0/0"
#     },
#   ]

#   egress_rules       = ["all-all"]
#   egress_cidr_blocks = ["0.0.0.0/0"]

#   depends_on = [
#     module.ypasko_vpc
#   ]
# }

# module "ypasko_sg_private" {
#   source  = "terraform-aws-modules/security-group/aws"
#   version = "4.9.0"

#   name        = "ypasko-sg-private"
#   description = "ypasko SG for ssh connection private"
#   vpc_id      = module.ypasko_vpc.vpc_id
#   # ingress_cidr_blocks = ["${local.vpc_cidr}"]
#   # ingress_rules       = ["ssh-tcp"]

#   # ingress_with_cidr_blocks = [
#   #   {
#   #     from_port   = 22
#   #     to_port     = 22
#   #     protocol    = 6
#   #     description = "SSH"
#   #     cidr_blocks = "0.0.0.0/0"
#   #   },
#   # ]

#   ingress_with_source_security_group_id = [
#     {
#       rule                     = "ssh-tcp"
#       source_security_group_id = module.ypasko_sg.security_group_id
#     },
#     # {
#     #   from_port                = 22
#     #   to_port                  = 22
#     #   protocol                 = 6
#     #   description              = "SSH from public SG"
#     #   source_security_group_id = module.ypasko_sg.security_group_id
#     # },
#   ]

#   egress_rules       = ["all-all"]
#   egress_cidr_blocks = ["0.0.0.0/0"]

#   depends_on = [
#     module.ypasko_vpc
#   ]
# }