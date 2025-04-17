# Création d'un bucket Object Storage
resource "oci_objectstorage_bucket" "bucket" {
  compartment_id = var.compartment_id
  name           = var.bucket_name
  namespace      = data.oci_objectstorage_namespace.ns.namespace
  access_type    = var.bucket_access
  
  # Activer le versionnement
  versioning = "Enabled"
  
  # Métadonnées
  metadata = {
    "created_by" = "terraform"
    "project"    = "projet-devops"
  }
}

# Récupération du namespace du tenant
data "oci_objectstorage_namespace" "ns" {
  compartment_id = var.compartment_id
}

# Création d'une politique de cycle de vie pour le bucket
resource "oci_objectstorage_object_lifecycle_policy" "bucket_lifecycle_policy" {
  namespace = data.oci_objectstorage_namespace.ns.namespace
  bucket    = oci_objectstorage_bucket.bucket.name

  rules {
    name = "archive-old-objects"
    action = "ARCHIVE"
    time_amount = 30
    time_unit = "DAYS"
    is_enabled = true
  }
} 