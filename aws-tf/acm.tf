resource "tls_private_key" "biz-key" {
  algorithm         = "RSA"
  rsa_bits          = "2048"
}

resource "tls_self_signed_cert" "biz-cert" {
  key_algorithm     = "RSA"
  private_key_pem   = tls_private_key.biz-key.private_key_pem

  subject {
    common_name     = var.domain-name
    organization    = "BIZ, LLC"
  }

  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_acm_certificate" "cert" {
  private_key       = tls_private_key.biz-key.private_key_pem
  certificate_body  = tls_self_signed_cert.biz-cert.cert_pem

  tags = {
    Name            = "biz-test-cert"
  }
}