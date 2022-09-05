locals{

    main_tags = {
      Name   = "ypasko-ec2"
      Environment = "test"
    }
    vpc_name = "ypasko-vpc"
    vpc_cidr = "172.16.0.0/16"

    public_subnet_suffix = "suffPubic"
    
    public_subnet_tags = {
        subnetType = "Public"
    }

    private_subnet_tags = {
        subnetType = "Private"
    }

    vpc_tags = {
        Name = local.vpc_name
    }

    network_acls = {
    default_inbound = [
      {
        rule_number = 900
        rule_action = "allow"
        from_port   = 1024
        to_port     = 65535
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
    ]
    default_outbound = [
      {
        rule_number = 900
        rule_action = "allow"
        from_port   = 1024
        to_port     = 65535
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
    ]
    public_inbound = [
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
      {
        rule_number = 110
        rule_action = "allow"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
      {
        rule_number = 120
        rule_action = "allow"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
      # {
      #   rule_number     = 140
      #   rule_action     = "allow"
      #   from_port       = 80
      #   to_port         = 80
      #   protocol        = "tcp"
      #   ipv6_cidr_block = "::/0"
      # },
    ]
    public_outbound = [
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
      {
        rule_number = 110
        rule_action = "allow"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
      {
        rule_number = 120
        rule_action = "allow"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
    ]
        private_inbound = [
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
      # {
      #   rule_number = 110
      #   rule_action = "allow"
      #   from_port   = 443
      #   to_port     = 443
      #   protocol    = "tcp"
      #   cidr_block  = "0.0.0.0/0"
      # },
      {
        rule_number = 120
        rule_action = "allow"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        # cidr_block  = "0.0.0.0/0"
        cidr_block  = local.vpc_cidr
      },
    ]
    private_outbound = [
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
      {
        rule_number = 110
        rule_action = "allow"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
      {
        rule_number = 120
        rule_action = "allow"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        # cidr_block  = "0.0.0.0/0"
        cidr_block  = local.vpc_cidr
      },
    ]
  }
}