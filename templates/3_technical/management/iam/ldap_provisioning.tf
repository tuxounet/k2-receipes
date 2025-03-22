provider "ldap" {

  host          = "localhost"
  port          = 31389
  bind_user     = "cn=admin,${var.ldap_base_dn}"
  bind_password = random_password.ldap_root_password.result
}

resource "ldap_ou" "org" {
  depends_on  = [kubernetes_manifest.ldap_service_external]
  name        = var.ldap_org
  ou          = "ou=${var.ldap_org},${var.ldap_base_dn}"
  description = "My OU description"
}
