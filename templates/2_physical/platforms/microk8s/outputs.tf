output "k8s_config" {
  value = abspath("${var.run_dir}/.k2/home/.kube/config")
}

