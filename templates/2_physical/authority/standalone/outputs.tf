output "root_ca_cert" {
  value = "${var.run_dir}/etc/pki/ca/ca.crt"
}

output "root_ca_key" {
  value = "${var.run_dir}/etc/pki/ca/ca.key"
}
