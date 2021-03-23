resource "aws_key_pair" "keys" {
  key_name                    = "keys"
  public_key                  = tls_private_key.biz-key.public_key_openssh
}

data "aws_ami" "vm" {
  most_recent                 = true
  owners                      = ["099720109477"]

  filter {
    name                      = "name"
    values                    = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name                      = "virtualization-type"
    values                    = ["hvm"]
  }
}

resource "aws_instance" "vm-1" {
  depends_on                  = [aws_security_group.vm]
  instance_type               = "t3.micro"
  ami                         = data.aws_ami.vm.id
  availability_zone           = var.zones[0]
  subnet_id                   = aws_subnet.public.0.id
  associate_public_ip_address = true
  monitoring                  = false
  ebs_optimized               = false
  vpc_security_group_ids      = [aws_security_group.vm.id]
  key_name                    = "keys"

  root_block_device {
    volume_type               = "gp2"
    volume_size               = 8
    delete_on_termination     = true
  }

   user_data =<<EOF
#!/bin/bash
apt-get update
apt-get install -y jq telnet mc curl nginx net-tools
systemctl enable nginx
systemctl restart nginx
echo WELCOME TO BIZ-TEST! > /var/www/html/index.html
EOF

  tags = {
    Name                      = "vm-1.${var.domain-name}"
  }
}