data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "devops-ansible"
  owners           = ["self"]
}


data "aws_caller_identity" "owner_id" {}

data "aws_route53_zone" "domain" {
  value = var.dns_domain
}