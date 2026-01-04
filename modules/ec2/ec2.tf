variable "env" {}
variable "tags" {}
variable "name" {}
variable "subnet_id" {}

locals {
  instance_type_by_env = {
    dev     = "t3.micro"
    staging = "t3.micro"
    prod    = "t3.small"
  }

  instance_type     = lookup(local.instance_type_by_env, var.env, "t3.micro")

  common_tags = merge(
    {
      environment = var.env
      Name        = "ec2-${var.env}-${var.name}"
    },
    var.tags
  )

}

resource "aws_instance" "web" {
  ami           = "ami-068c0051b15cdb816"
  instance_type = local.instance_type
  tags = local.common_tags
  subnet_id = var.subnet_id
}