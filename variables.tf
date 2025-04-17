variable "oci_region" {
  description = "Région OCI où déployer l'infrastructure"
  type        = string
  default     = "eu-frankfurt-1"  # Europe (Francfort)
}

variable "tenancy_ocid" {
  description = "OCID du tenancy OCI"
  type        = string
}

variable "user_ocid" {
  description = "OCID de l'utilisateur OCI"
  type        = string
}

variable "fingerprint" {
  description = "Empreinte de la clé API OCI"
  type        = string
}

variable "private_key_path" {
  description = "Chemin vers la clé privée OCI"
  type        = string
  default     = "~/.oci/oci_api_key.pem"
}

variable "compartment_id" {
  description = "OCID du compartiment OCI où déployer les ressources"
  type        = string
}

# Variables pour le VCN (Virtual Cloud Network)
variable "vcn_cidr" {
  description = "CIDR du VCN"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vcn_name" {
  description = "Nom du VCN"
  type        = string
  default     = "projet-devops-vcn"
}

variable "availability_domain" {
  description = "Domaine de disponibilité pour les ressources"
  type        = string
  default     = "AD-1"  # Généralement il y a AD-1, AD-2, AD-3
}

# Variables pour Compute Instance
variable "instance_shape" {
  description = "Type d'instance Compute"
  type        = string
  default     = "VM.Standard.E2.1.Micro"  # Eligible à l'offre gratuite
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

# Variables pour Object Storage
variable "bucket_name" {
  description = "Nom du bucket Object Storage"
  type        = string
  default     = "projet-devops-bucket"
}

variable "bucket_access" {
  description = "Niveau d'accès du bucket (NoPublicAccess, ObjectRead, ObjectReadWithoutList)"
  type        = string
  default     = "NoPublicAccess"
} 