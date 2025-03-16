resource "terraform_data" "example" {
  provisioner "local-exec" {
    command = "echo 'Hello, World!'"
  }
}