variable "compartment_id" {
  description = "OCID du compartiment OCI"
  type        = string
}

variable "bucket_name" {
  description = "Nom du bucket Object Storage"
  type        = string
}

variable "bucket_access" {
  description = "Niveau d'accès du bucket (NoPublicAccess, ObjectRead, ObjectReadWithoutList)"
  type        = string
  default     = "NoPublicAccess"
} 