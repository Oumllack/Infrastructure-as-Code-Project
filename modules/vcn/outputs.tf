output "vcn_id" {
  description = "ID du VCN créé"
  value       = oci_core_vcn.vcn.id
}

output "public_subnet_id" {
  description = "ID du sous-réseau public"
  value       = oci_core_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "ID du sous-réseau privé"
  value       = oci_core_subnet.private_subnet.id
} 