terraform {
  backend "local" {
    path = ".k2/state/current.tfstate"
  }
  required_providers {
  }
}

variable "space" {
  type = string
}

variable "instance_name" {
  type = string

}
module "k2_physical_platform" {
  source            = "./modules/microk8s"
  instance_name     = var.instance_name
  addon_registry    = true
  addon_storage     = true
  addon_dns         = true
  addon_ingress     = true
  addon_certmanager = true
}

output "name" {
  value = "Hello, World!  in ${var.space}"
}
