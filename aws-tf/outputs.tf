resource "local_file" "id_rsa" {
  filename = "out/id_rsa"
  content  = tls_private_key.biz-key.private_key_pem
  provisioner "local-exec" {
    command = "chmod 600 ./out/id_rsa"
  }
}

resource "local_file" "id_rsa_pub" {
  filename = "out/id_rsa.pub"
  content  = tls_private_key.biz-key.public_key_openssh
  provisioner "local-exec" {
    command = "chmod 600 ./out/id_rsa.pub"
  }
}

output "ssh" {
  description = "SSH command"
  value       = "ssh -i out/id_rsa ubuntu@${aws_instance.vm-1.public_dns}"
}

output "curl" {
  description = "Curl command"
  value       = "curl ${aws_instance.vm-1.public_dns}"
}

output "curl_elb" {
  description = "Curl ELB command"
  value       = "curl ${aws_elb.biz-lb.dns_name}"
}

output "curl_elb_https" {
  description = "Curl ELB HTTPS command"
  value       = "curl -k https://${aws_elb.biz-lb.dns_name}"
}