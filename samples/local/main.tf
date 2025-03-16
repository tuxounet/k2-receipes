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
  source        = "./modules/microk8s"
  instance_name = var.instance_name
}

output "name" {
  value = "Hello, World!  in ${var.space}"
}
