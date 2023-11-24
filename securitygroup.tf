
// nacl //

# nacl for public subnet


resource "aws_network_acl" "public_NACL" {
    vpc_id = aws_vpc.my_vpc.id
    subnet_ids = [aws_subnet.public_subnet.id]

    egress {
        protocol = "tcp"
        rule_no     = 200
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 443
        to_port = 443
    }

    ingress {

        protocol = "icmp"
        rule_no = 100
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 1
        to_port = 100

    }
  

}

# nacl for private subnet


resource "aws_network_acl" "private_NACL" {
    vpc_id = aws_vpc.my_vpc.id
    subnet_ids = [aws_subnet.aws_subnet.Private_subnet.id]

    egress {
        protocol = "tcp"
        rule_no     = 200
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 443
        to_port = 443
    }

    ingress {

        protocol = "icmp"
        rule_no = 100
        action = "allow"
        cidr_block = var.vpc_cidr
        from_port = 1
        to_port = 100

    }
  

}

# security group

resource "aws_security_group" "SG_for_pub_ec2" {
    vpc_id = aws_vpc.my_vpc.id
    name = " public SG"

    ingress {
        cidr_blocks = "0.0.0.0/0"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        
    }
     egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    name = "public sg"
  }
}

