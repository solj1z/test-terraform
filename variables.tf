variable "vpn_ip" {
    type = map(string)
    default = {
        inbound = "196.77.2.98/32"
        outbound = "0.0.0.0/0"
    }
}

 

variable "aws_ami" {
    type = list(string)
    default = ["ami-068c0051b15cdb816", "ami-0ecb62995f68bb549" ]
}

variable "availability_zones" {
    type = list(string)
    default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

/*
variable "instance_sizes" {
  type = map(string)
  default = {
    "dev" = "t3.micro"
    "prod" = "t3.small"
    "staging" = "t2.small"
  }
}

variable "env" {
  default = "staging"
}

variable "app" {
  type = string
  default = "k8s"
}

variable "region" {
  type = string
  default = "us-east-1"
}
*/




