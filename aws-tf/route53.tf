resource "aws_route53_zone" "biz-test" {
  name            = var.domain-name
  comment         = "test domain"

  tags = {
    Name          = var.domain-name
  }
}

resource "aws_route53_record" "biz-test" {
 zone_id         = aws_route53_zone.biz-test.zone_id
 name            = "api"
 type            = "CNAME"
 ttl             = "60"

 weighted_routing_policy {
   weight        = 10
 }

 set_identifier  = "biz-test"
 records         = [aws_elb.biz-lb.dns_name]
}

resource "aws_route53_record" "vm-1" {
 depends_on      = [aws_instance.vm-1]
 zone_id         = aws_route53_zone.biz-test.zone_id
 name            = "vm-1"
 type            = "A"
 ttl             = "60"

 weighted_routing_policy {
   weight        = 10
 }

 set_identifier  = "vm-1"
 records         = [aws_instance.vm-1.public_ip]
}