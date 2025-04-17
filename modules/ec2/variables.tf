variable "vpc_id" {
  description = "ID du VPC où l'instance EC2 sera déployée"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs des sous-réseaux publics où l'instance EC2 peut être déployée"
  type        = list(string)
}

variable "instance_type" {
  description = "Type d'instance EC2"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Nom de la clé SSH pour accéder à l'instance"
  type        = string
}

variable "instance_name" {
  description = "Nom de l'instance EC2"
  type        = string
  default     = "projet-devops-instance"
} 