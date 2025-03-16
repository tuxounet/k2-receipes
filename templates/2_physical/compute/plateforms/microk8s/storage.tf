
resource "terraform_data" "microk8s_addons_storage" {
  count      = var.addon_storage ? 1 : 0
  depends_on = [terraform_data.microk8s_setup]
  triggers_replace = [
    fileexists("../../.k2/state/status/microk8s.storage"),
  ]



  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        ADDON_ENABLED=$(microk8s.status --format short -a hostpath-storage | grep enabled | wc -l)
        if [ $ADDON_ENABLED -eq 0 ]; then
            microk8s.enable hostpath-storage
        fi
        mkdir -p $(pwd)/.k2/state/status
        touch $(pwd)/.k2/state/status/microk8s.storage        

        mkdir -p $(pwd)/.k2/home/data

        cat <<EOF | microk8s.kubectl apply -f -
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: "${var.instance_name}"
provisioner: microk8s.io/hostpath
parameters:
  pvDir: "$(pwd)/.k2/home/data"
volumeBindingMode: WaitForFirstConsumer
EOF

    EOT
  }

  provisioner "local-exec" {
    when        = destroy
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        ADDON_ENABLED=$(microk8s.status --format short -a hostpath-storage | grep enabled | wc -l)
        if [ $ADDON_ENABLED -eq 1 ]; then
            microk8s.disable hostpath-storage
        fi
        rm -rf $(pwd)/.k2/state/status/microk8s.storage
    EOT
  }


}
