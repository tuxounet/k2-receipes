resource "terraform_data" "microk8s_setup" {
  triggers_replace = [
    fileexists("${var.run_dir}/state/status/microk8s"),
    fileexists("${var.run_dir}/home/.kube/config"),
  ]

   input = {
    run_dir      = var.run_dir
  
  }


  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        SNAP_PRESENT=$(snap list | grep "^microk8s" | wc -l)
        if [ $SNAP_PRESENT -eq 0 ]; then
            sudo snap install microk8s --classic            
            mkdir -p ${self.input.run_dir}/state/status
            touch ${self.input.run_dir}/state/status/microk8s
            sudo usermod -a -G microk8s $(whoami)        
            newgrp microk8s
            sleep 15
        fi
        microk8s status --wait-ready        
        mkdir -p ${self.input.run_dir}/home/.kube
        microk8s config > ${self.input.run_dir}/home/.kube/config        
        
    EOT
  }

  provisioner "local-exec" {
    when        = destroy
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        SNAP_PRESENT=$(snap list | grep "^microk8s" | wc -l)
        if [ $SNAP_PRESENT -eq 1 ]; then
            sudo snap remove microk8s   
            rm -rf ${self.input.run_dir}/state/status/microk8s
        fi

        rm -rf ${self.input.run_dir}/home/.kube
        
    EOT
  }


}
