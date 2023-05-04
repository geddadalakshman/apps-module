data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "devops-ansible"
  owners           = ["self"]
}


data "aws_route53_zone" "domain" {
  name = var.dns_domain
}


data "aws_caller_identity" "account" {}

