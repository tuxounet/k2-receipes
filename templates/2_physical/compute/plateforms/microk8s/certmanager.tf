
resource "terraform_data" "microk8s_addons_certmanager" {
  count      = var.addon_certmanager ? 1 : 0
  depends_on = [terraform_data.microk8s_setup]
  triggers_replace = [
    fileexists("../../.k2/state/status/microk8s.certmanager"),
  ]



  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        ADDON_ENABLED=$(microk8s.status --format short -a cert-manager | grep enabled | wc -l)
        if [ $ADDON_ENABLED -eq 0 ]; then
            microk8s.enable cert-manager
        fi
        mkdir -p $(pwd)/.k2/state/status
        touch $(pwd)/.k2/state/status/microk8s.certmanager        
    EOT
  }

  provisioner "local-exec" {
    when        = destroy
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        ADDON_ENABLED=$(microk8s.status --format short -a cert-manager | grep enabled | wc -l)
        if [ $ADDON_ENABLED -eq 1 ]; then
            microk8s.disable cert-manager
        fi
        rm -rf $(pwd)/.k2/state/status/microk8s.certmanager
    EOT
  }


}
