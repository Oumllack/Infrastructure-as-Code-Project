output "bucket_id" {
  description = "ID du bucket Object Storage créé"
  value       = oci_objectstorage_bucket.bucket.id
}

output "bucket_name" {
  description = "Nom du bucket Object Storage"
  value       = oci_objectstorage_bucket.bucket.name
}

output "bucket_namespace" {
  description = "Namespace du bucket Object Storage"
  value       = data.oci_objectstorage_namespace.ns.namespace
} 