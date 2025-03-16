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
variable "run_dir" {
  type = string

}

module "k2_physical_authority" {
  source         = "./modules/authority"
  ca_common_name = "${var.instance_name}-${var.space}.k2"
}


module "k2_physical_platform" {
  source            = "./modules/microk8s"
  run_dir           = var.run_dir
  addon_registry    = true
  addon_storage     = true
  addon_dns         = true
  addon_ingress     = true
  addon_certmanager = false
}

output "config" {
  value = "Hello, World!  in ${module.k2_physical_platform.k8s_config}"
}
