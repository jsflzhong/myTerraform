terraform {
  required_version = ">= 1.0.0"  # 指定 Terraform 版本

  backend "s3" {  # 远程状态存储在 S3
    bucket = "my-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region  # 使用变量定义 AWS 区域
}

# 定义变量
variable "aws_region" {
  description = "AWS 运行的区域"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 实例类型"
  type        = string
  default     = "t2.micro"
}

variable "tags" {
  description = "资源标签"
  type        = map(string)
  default = {
    Name        = "Terraform-Instance"
    Environment = "Dev"
  }
}

# 通过数据源获取最新的 Amazon Linux 2 AMI
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

# 创建 EC2 实例
resource "aws_instance" "example" {
  ami           = data.aws_ami.latest_amazon_linux.id  # 使用数据源获取的 AMI
  instance_type = var.instance_type  # 使用变量
  tags          = var.tags  # 赋值标签

  provisioner "local-exec" {
    command = "echo Instance created: ${self.public_ip}"
  }
}

# 创建 S3 存储桶
resource "aws_s3_bucket" "example" {
  bucket = "my-terraform-bucket-${random_string.suffix.result}"
  acl    = "private"  # 访问控制
}

# 生成随机字符串用于 S3 存储桶名称
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# 使用条件语句 - 仅当环境为 "prod" 时创建一个额外的 S3 备份桶
resource "aws_s3_bucket" "backup" {
  count  = var.tags["Environment"] == "prod" ? 1 : 0
  bucket = "backup-bucket-${random_string.suffix.result}"
  acl    = "private"
}

# 输出 EC2 实例的公有 IP
output "instance_ip" {
  description = "EC2 实例的公有 IP 地址"
  value       = aws_instance.example.public_ip
}

# 输出 S3 存储桶的名称
output "s3_bucket_name" {
  description = "创建的 S3 存储桶名称"
  value       = aws_s3_bucket.example.bucket
}

# 使用模块来创建 VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"
  name    = "my-vpc"
  cidr    = "10.0.0.0/16"
}
