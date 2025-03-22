terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.36.0"
    }
     ldap = {
      source  = "Ouest-France/ldap"
    }
  }
}
provider "kubernetes" {
  config_path = var.k8s_config

}

