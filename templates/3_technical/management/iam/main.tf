resource "helm_release" "management_iam" {
  name  = "management-iam"
  chart = "${path.module}/chart"

  values = [
    file("${path.module}/values.yaml")
  ]
}
