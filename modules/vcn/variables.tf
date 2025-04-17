variable "compartment_id" {
  description = "OCID du compartiment OCI"
  type        = string
}

variable "vcn_cidr" {
  description = "CIDR du VCN"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vcn_name" {
  description = "Nom du VCN"
  type        = string
}

variable "availability_domain" {
  description = "Domaine de disponibilité pour les ressources"
  type        = string
} 