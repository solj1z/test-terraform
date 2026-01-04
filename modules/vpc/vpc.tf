variable "env" {}
variable "vpc_id" {}
locals {
  az_by_env = {
    dev     = "us-east-1b"
    staging = "us-east-1c"
    prod    = "us-east-1a"
}
    cidr_by_env = {
    dev     = "10.0.2.0/24"
    staging = "10.0.3.0/24"
    prod    = "10.0.4.0/24"
  }
}




resource "aws_subnet" "public" {
    for_each = toset(var.env)
    vpc_id            = var.vpc_id
    cidr_block        = local.cidr_by_env[each.key]
    availability_zone = local.az_by_env[each.key]
    map_public_ip_on_launch = true
    tags = {
      Name = "public_subnet_${each.key}"
    }
}

output "public_subnet_ids" {
  value = { for env, subnet in aws_subnet.public : env => subnet.id }
  
}