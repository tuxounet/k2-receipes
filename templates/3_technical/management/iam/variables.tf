variable "k8s_config" {
  type        = string
  description = "The k8s config path" 
}

variable "ldap_org" {
  type        = string
  description = "The ldap organisation" 
}

variable "ldap_domain" {
  type        = string
  description = "The ldap domain" 
}

variable "ldap_base_dn" {
  type        = string
  description = "The ldap base dn" 
}

variable "ldap_root_password" {
  type        = string
  description = "The ldap root password" 
  
}
