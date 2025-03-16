
resource "terraform_data" "microk8s_addons_dns" {
  count      = var.addon_ingress ? 1 : 0
  depends_on = [terraform_data.microk8s_setup]
  triggers_replace = [
    fileexists("../../.k2/state/status/microk8s.ingress"),
  ]



  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        ADDON_ENABLED=$(microk8s.status --format short -a dns | grep enabled | wc -l)
        if [ $ADDON_ENABLED -eq 0 ]; then
            microk8s.enable dns
        fi
        mkdir -p $(pwd)/.k2/state/status
        touch $(pwd)/.k2/state/status/microk8s.dns        
    EOT
  }

  provisioner "local-exec" {
    when        = destroy
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        ADDON_ENABLED=$(microk8s.status --format short -a dns | grep enabled | wc -l)
        if [ $ADDON_ENABLED -eq 1 ]; then
            microk8s.disable dns
        fi
        rm -rf $(pwd)/.k2/state/status/microk8s.dns
    EOT
  }


}
