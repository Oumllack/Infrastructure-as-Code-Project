variable "compartment_id" {
  description = "OCID du compartiment OCI"
  type        = string
}

variable "availability_domain" {
  description = "Domaine de disponibilité pour l'instance"
  type        = string
}

variable "subnet_id" {
  description = "ID du sous-réseau où l'instance sera déployée"
  type        = string
}

variable "instance_shape" {
  description = "Type d'instance Compute"
  type        = string
  default     = "VM.Standard.E2.1.Micro"  # Éligible à l'offre gratuite
}

variable "ssh_public_key" {
  description = "Clé SSH publique pour l'accès à l'instance"
  type        = string
}

variable "instance_name" {
  description = "Nom de l'instance Compute"
  type        = string
  default     = "projet-devops-instance"
} 