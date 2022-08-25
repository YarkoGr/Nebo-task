module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.1.4"

  name = "bastion"

  ami                    = "ami-052efd3df9dad4825"
  instance_type          = "t2.micro"
  key_name               = module.key_pair.key_pair_name
  availability_zone      = element(module.ypasko_vpc.azs, 0)
  subnet_id              = element(module.ypasko_vpc.public_subnets, 0)
  associate_public_ip_address = true
  vpc_security_group_ids = ["${module.ypasko_sg.security_group_id}"]

  tags = {
      Name   = "ypasko-ec2-bastion"
      Environment = "test"
    }

  depends_on = [
    module.ypasko_vpc, module.key_pair, module.ypasko_sg
  ]
}
