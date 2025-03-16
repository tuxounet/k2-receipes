
variable "run_dir" {
  type        = string
  description = "The run directory"  
}

variable "addon_registry" {
  type        = bool
  description = "Enable the registry"
  default     = false
}
variable "addon_storage" {
  type        = bool
  description = "Enable the storage"
  default     = false

}
variable "addon_ingress" {
  type        = bool
  description = "Enable the ingress"
  default     = false
}
variable "addon_dns" {
  type        = bool
  description = "Enable the dns"
  default     = false
}

variable "addon_certmanager" {
  type        = bool
  description = "Enable the certmanager"
  default     = false
  
}