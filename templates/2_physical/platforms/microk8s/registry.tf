module "k2_enable_microk8s_registry" {
  depends_on   = [terraform_data.microk8s_setup]
  count        = var.addon_registry ? 1 : 0
  source       = "./modules/feature/"
  run_dir      = var.run_dir
  feature_name = "registry"

}
