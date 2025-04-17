# Récupérer la dernière image Oracle Linux disponible
data "oci_core_images" "os_images" {
  compartment_id           = var.compartment_id
  operating_system         = "Oracle Linux"
  operating_system_version = "8"
  shape                    = var.instance_shape
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

# Création d'une instance Compute
resource "oci_core_instance" "instance" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  shape               = var.instance_shape
  display_name        = var.instance_name

  # Configuration de base
  create_vnic_details {
    subnet_id        = var.subnet_id
    display_name     = "${var.instance_name}-vnic"
    assign_public_ip = true
  }

  # Configuration de l'image
  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.os_images.images[0].id
  }

  # Ajout de la clé SSH
  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }

  # Script de démarrage pour installer un serveur web
  metadata = {
    user_data = base64encode(<<-EOF
      #!/bin/bash
      dnf update -y
      dnf install -y httpd
      systemctl start httpd
      systemctl enable httpd
      echo "<h1>Bienvenue sur le serveur web du Projet DevOps avec Oracle Cloud</h1>" > /var/www/html/index.html
      EOF
    )
  }

  # Configuration des volumes
  shape_config {
    ocpus = 1
    memory_in_gbs = 1
  }
} 