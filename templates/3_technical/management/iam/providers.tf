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

provider "ldap" {
  host          = "ldap.mycompany.tld"
  port          = 389
  bind_user     = "ldap_user"
  bind_password = "ldap_password"
}
