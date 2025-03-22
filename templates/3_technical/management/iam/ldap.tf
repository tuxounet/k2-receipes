

resource "random_password" "ldap_root_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

output "ldap_root_password" {
  value = random_password.ldap_root_password.result

}

resource "kubernetes_manifest" "ldap_deployment" {
  manifest = {
    apiVersion = "apps/v1"
    kind       = "Deployment"
    metadata = {
      "name"      = "ldap"
      "namespace" = kubernetes_namespace.management_iam.metadata.0.name
    }
    spec = {
      progressDeadlineSeconds = 600
      replicas                = 1
      revisionHistoryLimit    = 10
      selector = {
        matchLabels = {
          "app" = "ldap"
        }
      }
      strategy = {
        rollingUpdate = {
          maxSurge       = "25%"
          maxUnavailable = "25%"
        }
        type = "RollingUpdate"
      }
      template = {
        metadata = {
          labels = {
            "app" = "ldap"
          }
        }
        spec = {
          containers = [
            {
              image           = "docker.io/osixia/openldap:1.5.0",
              imagePullPolicy = "IfNotPresent"
              name            = "ldap"
              ports = [
                {
                  containerPort = 389
                  name          = "ldap"
                  protocol      = "TCP"
                },
              ]
              env = [
                {
                  name  = "TZ"
                  value = "Europe/Paris"
                },
                {
                  name  = "LDAP_ORGANISATION"
                  value = var.ldap_org
                },
                {
                  name  = "LDAP_DOMAIN"
                  value = var.ldap_domain
                },
                {
                  name  = "LDAP_BASE_DN"
                  value = var.ldap_base_dn
                },
                {
                  name  = "LDAP_TLS"
                  value = "false"
                },
                {
                  name  = "LDAP_ADMIN_PASSWORD"
                  value = random_password.ldap_root_password.result
                },
                {
                  name  = "LDAP_READONLY_USER"
                  value = "true"
                },
                {
                  name  = "LDAP_READONLY_USER_USERNAME"
                  value = "readonly"
                },
                {
                  name  = "LDAP_READONLY_USER_PASSWORD"
                  value = "onlyread"
                }
              ]
              resources = {}
            },
          ]
          restartPolicy                 = "Always"
          securityContext               = {}
          terminationGracePeriodSeconds = 30
        }
      }

    }
  }
}

resource "kubernetes_manifest" "ldap_service_internal" {
  manifest = {
    apiVersion = "v1"
    kind       = "Service"
    metadata = {
      "name"      = "ldap"
      "namespace" = kubernetes_namespace.management_iam.metadata.0.name
    }
    spec = {
      ports = [
        {
          name       = "ldap"
          port       = 389
          protocol   = "TCP"
          targetPort = 389
        },
      ]
      selector = {
        "app" = "ldap"
      }
      type = "ClusterIP"
    }
  }
}


resource "kubernetes_manifest" "ldap_service_external" {
  manifest = {
    apiVersion = "v1"
    kind       = "Service"
    metadata = {
      "name"      = "ldap-external"
      "namespace" = kubernetes_namespace.management_iam.metadata.0.name
    }
    spec = {
      ports = [
        {
          name       = "ldap"
          port       = 389
          protocol   = "TCP"
          nodePort  = 46389
        },
      ]
      selector = {
        "app" = "ldap"
      }
      type = "NodePort"


    }
  }
}
