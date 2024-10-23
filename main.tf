variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "ami_os" {
  description = "Operating system for the AMI (ubuntu or amazon-linux)"
  type        = string
  default     = "ubuntu"
}

provider "aws" {
  region = "eu-west-1"
}

locals {
  ami_ids = {
    "ubuntu"       = "ami-042ad9eecad9f5bd7"
    "amazon-linux" = "ami-0a8e758f5e873d1c1"
  }
}

resource "aws_instance" "example" {
  count         = var.instance_count
  instance_type = var.instance_type
  ami           = local.ami_ids[var.ami_os]

  tags = {
    Name = "Instance-${count.index + 1}"
  }
}
