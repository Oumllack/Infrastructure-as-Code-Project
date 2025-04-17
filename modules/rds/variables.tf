variable "vpc_id" {
  description = "ID du VPC où la base de données RDS sera déployée"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs des sous-réseaux privés où la base de données RDS sera déployée"
  type        = list(string)
}

variable "db_name" {
  description = "Nom de la base de données"
  type        = string
}

variable "db_username" {
  description = "Nom d'utilisateur pour la base de données"
  type        = string
}

variable "db_password" {
  description = "Mot de passe pour la base de données"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "Type d'instance pour la base de données"
  type        = string
  default     = "db.t3.micro"
} 