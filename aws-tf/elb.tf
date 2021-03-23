resource "aws_elb" "biz-lb" {
  name                        = "biz-tf-elb"
  subnets                     = aws_subnet.public.*.id
  security_groups             = [aws_security_group.sg.id]

  listener {
    instance_port             = 80
    instance_protocol         = "http"
    lb_port                   = 80
    lb_protocol               = "http"
  }

  listener {
    instance_port             = 80
    instance_protocol         = "http"
    lb_port                   = 443
    lb_protocol               = "https"
    ssl_certificate_id        = aws_acm_certificate.cert.arn
  }

  instances                   = [aws_instance.vm-1.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name                      = "biz-tf-elb"
  }
}