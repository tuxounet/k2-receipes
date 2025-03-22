resource "terraform_data" "authority_ca" {
  triggers_replace = [
    fileexists("${var.run_dir}/etc/pki/ca/ca.key"),
    fileexists("${var.run_dir}/etc/pki/ca/ca.crt"),
  ]
 


  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
              
        mkdir -p ${var.run_dir}/etc/pki/ca       
        if [ ! -f ${var.run_dir}/etc/pki/ca/ca.key ]; then
            openssl genrsa -out ${var.run_dir}/etc/pki/ca/ca.key 4096
        fi

        if [ ! -f ${var.run_dir}/etc/pki/ca/ca.crt ]; then
            openssl req -x509 -new -nodes -key ${var.run_dir}/etc/pki/ca/ca.key -sha256 -days 3650 -out ${var.run_dir}/etc/pki/ca/ca.crt -subj "/C=US/ST=CA/L=San Francisco/O=K2/OU=K2/CN=${var.ca_common_name}"
        fi
 
    EOT
  }
 


}
