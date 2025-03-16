

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

variable "var_name" {
  type = string
}



output "name" {
  value = "Hello, World!  in ${var.space} ${var.var_name}"
}
