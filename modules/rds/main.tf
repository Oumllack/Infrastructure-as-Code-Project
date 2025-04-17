# Création d'un groupe de sécurité pour la base de données RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Groupe de sécurité pour la base de données RDS"
  vpc_id      = var.vpc_id

  # Autoriser le trafic MySQL/PostgreSQL entrant depuis le groupe de sécurité EC2
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    self            = true
    security_groups = []  # Sera rempli par la suite avec l'ID du groupe de sécurité EC2
    description     = "Accès MySQL depuis EC2"
  }

  # Aucun trafic sortant n'est nécessaire pour RDS
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Tout le trafic sortant"
  }

  tags = {
    Name = "rds-security-group"
  }
}

# Création d'un groupe de sous-réseaux pour RDS
resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "rds-subnet-group"
  description = "Groupe de sous-réseaux pour RDS"
  subnet_ids  = var.private_subnet_ids

  tags = {
    Name = "rds-subnet-group"
  }
}

# Création d'une instance RDS
resource "aws_db_instance" "database" {
  identifier              = "projet-devops-db"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = var.db_instance_class
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true
  deletion_protection     = false
  backup_retention_period = 7
  multi_az                = false

  tags = {
    Name = "projet-devops-database"
  }
} 