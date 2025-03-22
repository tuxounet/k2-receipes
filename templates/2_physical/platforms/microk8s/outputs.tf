output "k8s_config" {
  value = abspath("${var.run_dir}/home/.kube/config")
}

