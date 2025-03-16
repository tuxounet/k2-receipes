

terraform {

  backend "local" {
    path = ".k2/state/terraform.tfstate"
  }

  required_providers {

  }

}



variable "space" {
  type = string

}




output "name" {
  value = "Hello, World!  in ${var.space}"
}
