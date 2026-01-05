terraform {
  backend "s3" {
    bucket = "my-unique-replicated-bucket-12345-soso"
    key    = "terraform/dev/terraform.tfstate"
    region = "us-east-1"
    profile = "sola-terraform"
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "sola-terraform"
  }


provider "aws" {
  alias   = "secondary"
  region  = "us-west-2"
  profile = "new"
}

resource "aws_s3_bucket" "state_backend" {
  bucket = "my-unique-replicated-bucket-12345-soso"
  tags = {
    Name        = "s3_terraform_bucket"
  }
}

#resource "aws_vpc" "soso" {
#  cidr_block = "10.0.0.0/16"
#  enable_dns_support   = true
#  enable_dns_hostnames = true
#  tags = {
#    Name = "soso_vpc"
#  }
#}

#resource "aws_subnet" "soso_public_subnet" {
#  vpc_id                  = aws_vpc.soso.id
#  cidr_block              = "10.0.1.0/24"
#  availability_zone       = "us-east-1a"
#  map_public_ip_on_launch = true
#  tags = {
#    Name = "soso_public_subnet"
#  }
#}

#resource "aws_subnet" "soso_private_subnet" {
#  vpc_id            = aws_vpc.soso.id
#  cidr_block        = "10.0.2.0/24"
#  availability_zone = "us-east-1a"
#  tags = {
#    Name = "soso_private_subnet"
#  }
#}

#resource "aws_internet_gateway" "soso_igw" {
#  vpc_id = aws_vpc.soso.id

#  tags = {
#    Name = "soso_internet_gateway"
#  }
#}

#resource "aws_instance" "web" {
#  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (HVM), SSD Volume Type
#  instance_type = "t3.micro"
#  tags = {
#    Name = "WebServerInstance"
#  }
#  security_groups = [aws_security_group.local_access.name]
#}

#resource "aws_security_group" "local_access" {
#  name        = "local_access_sg"
#
#  description = "Allow access from local machine"
#  ingress {
#    from_port   = 22
#    to_port     = 22
#    protocol    = "tcp"
#    cidr_blocks = ["196.70.151.125/32"]
#}
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#  tags = {
#    Name = "local_access_sg"
#  }
#}

#output "web_instance_ip" {
#  value = aws_instance.web.public_ip
#  description = "Public IP of the web server instance"
# security group must be created before getting the IP
#  depends_on = [aws_security_group.local_access]
#}

#resource "aws_eip" "lb" {
#  domain = "vpc"
#  tags = {
#    Name = "load_balancer_eip"
#  }
#}

#output "eip_address" {
#  value = aws_eip.lb.public_ip
#  description = "Elastic IP address"
#}

#resource "aws_security_group" "allow_http" {
#  name        = "allow_http_sg"
#  description = "Allow HTTP inbound traffic"

#  ingress {
#    from_port   = 80
#    to_port     = 80
#    protocol    = "tcp"
#    cidr_blocks = ["${aws_eip.lb.public_ip}/32"]
#  }

#  tags = {
#    Name = "allow_http_for_eip_sg"
#  }
#}

#resource "aws_nat_gateway" "soso_NGA" {
#  allocation_id = aws_eip.lb.id
#  subnet_id     = "subnet-00173674448e55357"
#  tags = {
#    Name = "soso_nat_gateway"
#  } 
#}

#output "nat_gateway_id" {
#  value = aws_nat_gateway.soso_NGA.id
#  description = "NAT Gateway ID"
#}

#resource "aws_instance" "myec2" {
#  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (HVM), SSD Volume Type
#  instance_type = "t3.micro"
#  key_name = "visa"

# connection {
#  type        = "ssh"
# user        = "ec2-user"
#private_key = file("C:\\Users\\JAZ\\Desktop\\ssh\\visa.pem")
#host        = self.public_ip
#}

#tags = {
# Name = "MyEC2Instance"
#}

#provisioner "remote-exec" {
# inline = [
#  "sudo yum update -y",
# "sudo yum install -y httpd",
#"sudo systemctl start httpd",
#"sudo systemctl enable httpd",
#"echo '<h1>Welcome to My EC2 Instance</h1>' | sudo tee /var/www/html/index.html"
#]

#}

#}

#output "myec2_public_ip" {  value = aws_instance.myec2.public_ip
# description = "Public IP of My EC2 Instance"
#}


#data "aws_ami" "example" {
#owners           = ["amazon"]

#filter {
# name   = "name"
#values = ["amzn2-ami-hvm*"]
#}
#}

#output "fetched_ami_id" {
#  value = data.aws_ami.example.id
# 
#}

#resource "aws_instance" "example" {
#  ami           = data.aws_ami.example.id
#  instance_type = "t3.micro"

# tags = {
#  Name = "ExampleInstance"
#}
#}

#data "aws_availability_zones" "av" {}
#data "aws_regions" "current" {}

#output "available_zones" {
#  value = data.aws_availability_zones.av.names
#}

#output "current_region" {
#  value = data.aws_regions.current.id
#}

#import {
#  to = aws_instance.web
#  id = "i-01cca9e3e5986e49b"
#}

#import {
#  to = aws_security_group.open_sg
#  id = "sg-00879becd7bb74958"
#}


#resource "aws_security_group" "local_access" {
#  name        = "local_access_sg"

#  description = "Allow access from local machine"
#  ingress {
#    from_port   = 22
#    to_port     = 22
#    protocol    = "tcp"
#    cidr_blocks = [var.vpn_ip.inbound]
#}
 # egress {
#   from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = [var.vpn_ip.outbound]
#  }

#  tags = {
#    Name = "local_access_sg"
#  }
#}

#resource "aws_instance" "mine" {
#  ami           = var.aws_ami[count.index] 
#  instance_type = "t3.micro"
#  count = 2
#  tags = {
#    Name = "k8s_${count.index}_instance"
#  }
#  security_groups = [aws_security_group.local_access.name]
#  availability_zone = var.availability_zones[0]
  
#}

#output "mine_instance_ips" {
#  value = aws_instance.mine.[*].public_ip
#  description = "Public IPs of the mine instances"
#  depends_on = [aws_security_group.local_access]
#}

#resource "aws_iam_user" "dev" {
#  for_each = toset(["sola_dev", "louk_dev", "mar_dev"])
#  name = each.key
#  tags = {
#    Role = "Developer"
#  }
  
#}

#resource "aws_instance" "dev_ec2" {
#  for_each = {
#    sola_dev = "t3.micro"
#    louk_dev = "t3.micro"
#    mar_dev  = "t3.small"
#  }
#  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (HVM), SSD Volume Type
#  instance_type = "${each.value}"
#  tags = {
#    Name = "${each.key}_instance"
#}
#}

#resource "aws_instance" "sh_dev" {
#  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (HVM), SSD Volume Type
#  instance_type = "t3.micro"
#  count = var.conditional == "dev" ? 1 : 0
#  tags = {
#    Name = "dev"
#  }
  
#}

#resource "aws_instance" "sh_prod" {
#  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (HVM), SSD Volume Type
#  instance_type = "t3.small"
#  count = var.conditional == "prod" ? 1 : 0
#  tags = {
#    Name = "prod"
#  }
  
#}

#resource "aws_instance" "test" {
#   ami           = local.instance_ami
#   instance_type = local.instance_type
#   tags = local.common_tags
#}

#variable "ami" {
#  type = map(string)
#  default = {
#    "us-east-1"  = "ami-0c02fb55956c7d316"
#    "us-west-2"  = "ami-02d8bad0a1da4b6fd"
#    "ap-south-1" = "ami-0b9ecf71fe947bbdd"
#  } 
#}


#locals {
#  instance_ami= lookup(var.ami, var.region, "please enter one of the following regions : us-east-1,us-west-2,ap-south-1")
#}

#locals {
#  common_tags = {
#    environment = var.env
#    app = var.app
#    ManagedBy = "terraform"
#  }
#}

#locals {
#  instance_type = lookup(var.instance_sizes, var.env, "t3.small")
#}
/*
variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

    }
  ]
}

resource "aws_security_group" "public_access" {
  name        = "public_access_sg"
  description = "Allow access to internet"
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
 
  tags = {
    Name = "public_access_sg"
  }
}

variable "external_ports" {
  type = list(number)
  default = [8080, 8443, 9000]
}

resource "aws_security_group" "external_access" {
  name        = "external_access_sg"
  description = "Allow access to external ports"
  dynamic "ingress" {
    for_each = var.external_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  tags = {
    Name = "external_access_sg"
  }
}

variable "buckets-name" {
  type = map(string)
  default = {
    "dev" = "my-unique-application-data-bucket-67890-dev"
    "staging" = "my-unique-application-data-bucket-67890-staging"
    "prod" = "my-unique-application-data-bucket-67890-prod"
  }
}

locals {
  logs_buckets = {
    for key, value in var.buckets-name :
    key => "${value}-logs"
  }
  assets_buckets = {
    for key, value in var.buckets-name :
    key => "${value}-assets"
  }

}

resource "aws_s3_bucket" "my_logs" {
  for_each = local.logs_buckets
  bucket = each.value

  tags = {
    Name        = "${each.key}_logs_bucket"
  }
}

resource "aws_s3_bucket" "my_assets" {
  for_each = local.assets_buckets
  bucket = each.value

  tags = {
    Name        = "${each.key}_assets_bucket"
  }
}


variable "environments" {
  type = list(string)
  default = ["dev", "staging", "prod"]
}

module "vpc_module" {
  source = "./modules/vpc"
  env = var.environments
  vpc_id = aws_vpc.new.id
}

module "ec2_module" {
  source = "./modules/ec2"
  for_each = toset(var.environments)
  env = each.key
  name = "appserver"
  tags = {
    Project = "SosoApp"
  }
  subnet_id = module.vpc_module.public_subnet_ids[each.key]
}

resource "aws_vpc" "new" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "new-vpc"
    }
}


locals {
  instance_type = terraform.workspace == "prod" ? "t3.small" : "t3.micro"
}
resource "aws_instance" "example" {
  ami           = "ami-068c0051b15cdb816"
  instance_type = local.instance_type
  tags = merge(
    {
      environment = terraform.workspace
    },
    {
      Name = "ExampleInstance"
    }
  ) 
}

module "github_repo" {
  source = "github.com/solj1z/test-terraform/modules"
}

## TERRAFORM REMOTE STATE EX:

# PROJECT A:

resource "aws_eip" "test" {
  domain = "vpc"
  tags = {
    Name = "test_eip"
  }
}

output "allocation_id" {
  value = aws_eip.test.allocation_id
  description = "Elastic IP allocation ID"
}

output "eip_ip" {
  value = aws_eip.test.public_ip
  description = "Elastic IP address"
}

# PROJECT B:

data "terraform_remote_state" "test" {
  backend = "s3"
  config = {
    bucket = "my-unique-replicated-bucket-12345-soso"
    key    = "terraform/dev/terraform.tfstate"
    region = "us-east-1"
    profile = "sola-terraform"
  }

}

resource "aws_instance" "use_eip" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t3.micro"
  tags = {
    Name = "UseEIPInstance"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.use_eip.id
  allocation_id = data.terraform_remote_state.test.outputs.allocation_id
}

*/
