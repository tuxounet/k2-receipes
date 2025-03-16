resource "terraform_data" "microk8s_enable" {
  triggers_replace = [
    fileexists("${ var.run_dir}/.k2/state/status/${var.feature_name}"),
  ]
  input = {
    run_dir      = var.run_dir
    feature_name = var.feature_name
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        ADDON_ENABLED=$(microk8s.status --format short -a ${self.input.feature_name} | grep enabled | wc -l)
        if [ $ADDON_ENABLED -eq 0 ]; then
            microk8s.enable ${self.input.feature_name}
        fi
        mkdir -p ${self.input.run_dir}/.k2/state/status
        touch ${self.input.run_dir}/.k2/state/status/microk8s.${self.input.feature_name}        
    EOT
  }

  provisioner "local-exec" {
    when        = destroy
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        ADDON_ENABLED=$(microk8s.status --format short -a ${self.input.feature_name} | grep enabled | wc -l)
        if [ $ADDON_ENABLED -eq 1 ]; then
            microk8s.disable ${self.input.feature_name}
        fi
        rm -rf ${self.input.run_dir}/.k2/state/status/microk8s.certmanager
    EOT
  }



}
