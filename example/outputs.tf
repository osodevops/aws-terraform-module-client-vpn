output "tls_locally_signed_cert_example_ca_cert_pem_output" {
  value = tls_locally_signed_cert.example.ca_cert_pem
}

output "tls_private_key_example_private_key_pem_output" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}