

resource "kubernetes_manifest" "dip_deployment" {
  manifest = {
    apiVersion = "apps/v1"
    kind       = "Deployment"
    metadata = {
      "name"      = "idp"
      "namespace" = kubernetes_namespace.management_iam.metadata.0.name
    }
    spec = {
      progressDeadlineSeconds = 600
      replicas                = 1
      revisionHistoryLimit    = 10
      selector = {
        matchLabels = {
          "app" = "idp"
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
              image           = "ghcr.io/authelia/authelia:4.38.17",
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
          targetPort = 389
          nodePort   = 31389
        },
      ]
      selector = {
        "app" = "ldap"
      }
      type = "NodePort"


    }
  }
}
