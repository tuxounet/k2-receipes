

module "k2_physical_layer" {
  source  = "./layers/1_physical"
  run_dir = var.run_dir
  space   = var.space

}

output "k2_physical_k8s_endpoint" {
  value = module.k2_physical_layer.k2_physical_platform.k8s_config
}

