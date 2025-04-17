variable "vpc_cidr" {
  description = "CIDR du VPC"
  type        = string
}

variable "vpc_name" {
  description = "Nom du VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDRs pour les sous-réseaux publics"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDRs pour les sous-réseaux privés"
  type        = list(string)
}

variable "availability_zones" {
  description = "Zones de disponibilité pour les sous-réseaux"
  type        = list(string)
} 