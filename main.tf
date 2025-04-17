terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
      version = "~> 4.0"
    }
  }
}

provider "oci" {
  region           = var.oci_region
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
}

# Module VPC (appelé VCN dans OCI)
module "vcn" {
  source = "./modules/vcn"
  
  vcn_cidr            = var.vcn_cidr
  vcn_name            = var.vcn_name
  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain
}

# Module Compute (équivalent EC2)
module "compute" {
  source = "./modules/compute"
  
  compartment_id       = var.compartment_id
  availability_domain  = var.availability_domain
  subnet_id            = module.vcn.public_subnet_id
  instance_shape       = var.instance_shape
  ssh_public_key       = var.ssh_public_key
  instance_name        = var.instance_name
  depends_on           = [module.vcn]
}

# Module Object Storage (équivalent S3)
module "object_storage" {
  source = "./modules/object_storage"
  
  compartment_id       = var.compartment_id
  bucket_name          = var.bucket_name
  bucket_access        = var.bucket_access
} 