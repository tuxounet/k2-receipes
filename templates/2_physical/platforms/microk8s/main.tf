resource "terraform_data" "microk8s_setup" {
  triggers_replace = [
    fileexists("${var.run_dir}/state/status/microk8s"),
    fileexists("${var.run_dir}/home/.kube/config"),
  ]

  input = var.run_dir

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        RUN_DIR=${self.input}
        SNAP_PRESENT=$(snap list | grep "^microk8s" | wc -l)
        if [ $SNAP_PRESENT -eq 0 ]; then
            sudo snap install microk8s --classic            
            mkdir -p $RUN_DIR/state/status
            touch $RUN_DIR/state/status/microk8s
            sudo usermod -a -G microk8s $(whoami)        
            newgrp microk8s
            sleep 15
        fi
        microk8s status --wait-ready        
        mkdir -p $RUN_DIR/home/.kube
        microk8s config > $RUN_DIR/home/.kube/config        
        
    EOT
  }

  provisioner "local-exec" {
    when        = destroy
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        RUN_DIR=${self.input}
        SNAP_PRESENT=$(snap list | grep "^microk8s" | wc -l)
        if [ $SNAP_PRESENT -eq 1 ]; then
            sudo snap remove microk8s   
            rm -rf $RUN_DIR/state/status/microk8s
        fi
        rm -rf $RUN_DIR/home/.kube

        
    EOT
  }


}
