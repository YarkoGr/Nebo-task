module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"
  version = "2.0.0"

  key_name           = "ypasko-bastion"
  create_private_key = true

  tags = local.main_tags
}

resource "local_file" "my_key" {
    content = "${module.key_pair.private_key_pem}"
    filename = "/home/ypasko/aws/${module.key_pair.key_pair_name}.pem"
}