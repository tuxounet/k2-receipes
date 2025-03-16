resource "terraform_data" "authority_ca" {
  triggers_replace = [
    fileexists("../../.k2/etc/pki/ca/ca.key"),
    fileexists("../../.k2/etc/pki/ca/ca.crt"),
  ]
 


  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
              
        mkdir -p $(pwd)/.k2/etc/pki/ca       
        if [ ! -f $(pwd)/.k2/etc/pki/ca/ca.key ]; then
            openssl genrsa -out $(pwd)/.k2/etc/pki/ca/ca.key 4096
        fi

        if [ ! -f $(pwd)/.k2/etc/pki/ca/ca.crt ]; then
            openssl req -x509 -new -nodes -key $(pwd)/.k2/etc/pki/ca/ca.key -sha256 -days 3650 -out $(pwd)/.k2/etc/pki/ca/ca.crt -subj "/C=US/ST=CA/L=San Francisco/O=K2/OU=K2/CN=${var.ca_common_name}"
        fi

    
    EOT
  }

  provisioner "local-exec" {
    when        = destroy
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        
        rm -rf $(pwd)/.k2/etc/pki/ca
        
    EOT
  }


}
