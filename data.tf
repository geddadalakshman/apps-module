data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "devops-ansible"
  owners           = ["self"]
}


