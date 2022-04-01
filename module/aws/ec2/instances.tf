variable "project" {}
variable "region" {}
variable "profile" {}
variable "attach_public_ip" {
  type = bool
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "example-server-keypair" {
  key_name   = "${var.project}-server-keypair"
  public_key = tls_private_key.example.public_key_openssh
}

resource "aws_instance" "example-server" {
  ami                         = "ami-028f0daffc74d96ee" // Ubuntu 21.10 LTS
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.example-server-keypair.key_name
  associate_public_ip_address = var.attach_public_ip
  disable_api_termination     = false
  monitoring                  = false

  root_block_device {
    volume_type           = "standard"
    volume_size           = 10
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name    = "${var.project}-${var.region}-server"
    Project = var.project
    Role    = "ec2"
    Backup  = "true"
  }
}