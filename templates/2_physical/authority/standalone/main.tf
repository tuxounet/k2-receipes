resource "terraform_data" "microk8s_setup" {
  triggers_replace = [
    fileexists("../../.k2/state/status/microk8s"),
    fileexists("../../.k2/home/.kube/config"),
  ]
 


  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        SNAP_PRESENT=$(snap list | grep "^microk8s" | wc -l)
        if [ $SNAP_PRESENT -eq 0 ]; then
            sudo snap install microk8s --classic            
            mkdir -p $(pwd)/.k2/state/status
            touch $(pwd)/.k2/state/status/microk8s
            sudo usermod -a -G microk8s $(whoami)        
            newgrp microk8s
          
        fi
        microk8s status --wait-ready        
        mkdir -p $(pwd)/.k2/home/.kube
        microk8s config > $(pwd)/.k2/home/.kube/config        
        
    EOT
  }

  provisioner "local-exec" {
    when        = destroy
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        SNAP_PRESENT=$(snap list | grep "^microk8s" | wc -l)
        if [ $SNAP_PRESENT -eq 1 ]; then
            sudo snap remove microk8s   
            rm -rf $(pwd)/.k2/state/status/microk8s
        fi

        rm -rf $(pwd)/.k2/home/.kube
        
    EOT
  }


}
