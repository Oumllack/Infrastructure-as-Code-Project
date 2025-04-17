# Création d'un groupe de sécurité pour l'instance EC2
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Groupe de sécurité pour les instances EC2"
  vpc_id      = var.vpc_id

  # Autoriser le trafic SSH entrant
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Accès SSH"
  }

  # Autoriser le trafic HTTP entrant
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Accès HTTP"
  }

  # Autoriser le trafic HTTPS entrant
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Accès HTTPS"
  }

  # Autoriser tout le trafic sortant
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Tout le trafic sortant"
  }

  tags = {
    Name = "ec2-security-group"
  }
}

# Récupérer l'AMI Amazon Linux 2 la plus récente
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Créer une instance EC2
resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.public_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  # Script de démarrage pour installer un serveur web
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Bienvenue sur le serveur web du Projet DevOps</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = var.instance_name
  }
} 