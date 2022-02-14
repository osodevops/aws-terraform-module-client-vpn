output "tls_self_signed_cert_cert_pem_output" {
  value = tls_self_signed_cert.ca.cert_pem
}

output "tls_private_key_pem_output" {
  value = tls_private_key.ca.private_key_pem
  sensitive = true
}