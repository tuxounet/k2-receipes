module "k2_enable_microk8s_storage" {
  depends_on = [
    terraform_data.microk8s_setup,
    module.k2_enable_microk8s_registry,
  ]
  count        = var.addon_storage ? 1 : 0
  source       = "./modules/feature/"
  run_dir      = var.run_dir
  feature_name = "hostpath-storage"
}


# resource "kubernetes_manifest" "local_storage_class" {
#   depends_on = [
#     terraform_data.microk8s_setup, 
#   ]
#   manifest = {
#     apiVersion = "storage.k8s.io/v1"
#     kind       = "StorageClass"
#     metadata = {
#       name = "local-storage"
#     }
#     provisioner = "microk8s.io/hostpath"
#     parameters = {
#       pvDir = "${var.run_dir}/.k2/home/data"

#     }
#     volumeBindingMode = "WaitForFirstConsumer"
#   }
#   timeouts {
#     create = "1m"
#     update = "1m"
#     delete = "30s"
#   }
# }
