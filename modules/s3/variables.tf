variable "bucket_name" {
  description = "Nom du bucket S3"
  type        = string
}

variable "bucket_acl" {
  description = "ACL pour le bucket S3 (private, public-read, etc.)"
  type        = string
  default     = "private"
} 