# Création du VCN (équivalent au VPC dans AWS)
resource "oci_core_vcn" "vcn" {
  compartment_id = var.compartment_id
  cidr_block     = var.vcn_cidr
  display_name   = var.vcn_name
  dns_label      = "vcn"
}

# Création d'une passerelle Internet
resource "oci_core_internet_gateway" "internet_gateway" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${var.vcn_name}-igw"
  enabled        = true
}

# Création d'un sous-réseau public
resource "oci_core_subnet" "public_subnet" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  vcn_id              = oci_core_vcn.vcn.id
  cidr_block          = cidrsubnet(var.vcn_cidr, 8, 0)  # 10.0.0.0/24
  display_name        = "${var.vcn_name}-public-subnet"
  dns_label           = "public"
  security_list_ids   = [oci_core_security_list.public_security_list.id]
  route_table_id      = oci_core_route_table.public_route_table.id
}

# Création d'un sous-réseau privé
resource "oci_core_subnet" "private_subnet" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  vcn_id              = oci_core_vcn.vcn.id
  cidr_block          = cidrsubnet(var.vcn_cidr, 8, 1)  # 10.0.1.0/24
  display_name        = "${var.vcn_name}-private-subnet"
  dns_label           = "private"
  prohibit_public_ip_on_vnic = true
  security_list_ids   = [oci_core_security_list.private_security_list.id]
  route_table_id      = oci_core_route_table.private_route_table.id
}

# Création d'une liste de sécurité pour le sous-réseau public
resource "oci_core_security_list" "public_security_list" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${var.vcn_name}-public-security-list"

  # Règles entrantes (ingress)
  ingress_security_rules {
    protocol  = "6" # TCP
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    protocol  = "6" # TCP
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options {
      min = 80
      max = 80
    }
  }

  # Règles sortantes (egress)
  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
    stateless   = false
  }
}

# Création d'une liste de sécurité pour le sous-réseau privé
resource "oci_core_security_list" "private_security_list" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${var.vcn_name}-private-security-list"

  # Règles entrantes (ingress) - Autoriser uniquement depuis le sous-réseau public
  ingress_security_rules {
    protocol  = "all"
    source    = cidrsubnet(var.vcn_cidr, 8, 0)  # 10.0.0.0/24 (public subnet)
    stateless = false
  }

  # Règles sortantes (egress)
  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
    stateless   = false
  }
}

# Création d'une table de routage pour le sous-réseau public
resource "oci_core_route_table" "public_route_table" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${var.vcn_name}-public-route-table"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
  }
}

# Création d'une table de routage pour le sous-réseau privé
resource "oci_core_route_table" "private_route_table" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${var.vcn_name}-private-route-table"
  
  # Note: sans NAT Gateway, le sous-réseau privé n'a pas d'accès à Internet
  # Pour ajouter un accès Internet, vous auriez besoin d'une NAT Gateway
} 