output "instance_id" {
  description = "ID de l'instance Compute créée"
  value       = oci_core_instance.instance.id
}

output "public_ip" {
  description = "Adresse IP publique de l'instance Compute"
  value       = oci_core_instance.instance.public_ip
} 