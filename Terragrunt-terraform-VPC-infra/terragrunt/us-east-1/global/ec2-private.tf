module "ec2_instance_private" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.1.4"

  name = "private-instance"

  ami                    = "ami-052efd3df9dad4825"
  instance_type          = "t2.micro"
  key_name               = module.key_pair.key_pair_name
  availability_zone      = element(module.ypasko_vpc.azs, 0)
  subnet_id              = element(module.ypasko_vpc.private_subnets, 0)
  associate_public_ip_address = false
  vpc_security_group_ids = ["${module.ypasko_sg_private.security_group_id}"]

  tags = {
      Name   = "ypasko-ec2-private"
      Environment = "test"
    }

  depends_on = [
    module.ypasko_vpc, module.key_pair, module.ypasko_sg
  ]
}