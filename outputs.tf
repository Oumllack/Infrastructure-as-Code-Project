# Sorties du module VCN
output "vcn_id" {
  description = "ID du VCN créé"
  value       = module.vcn.vcn_id
}

output "public_subnet_id" {
  description = "ID du sous-réseau public"
  value       = module.vcn.public_subnet_id
}

output "private_subnet_id" {
  description = "ID du sous-réseau privé"
  value       = module.vcn.private_subnet_id
}

# Sorties du module Compute
output "instance_id" {
  description = "ID de l'instance Compute"
  value       = module.compute.instance_id
}

output "instance_public_ip" {
  description = "Adresse IP publique de l'instance Compute"
  value       = module.compute.public_ip
}

# Sorties du module Object Storage
output "bucket_id" {
  description = "ID du bucket Object Storage"
  value       = module.object_storage.bucket_id
}

output "bucket_name" {
  description = "Nom du bucket Object Storage"
  value       = module.object_storage.bucket_name
}