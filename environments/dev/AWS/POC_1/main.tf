provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./vpc"
}

module "eks" {
  source = "./eks"
    vpc_id = module.vpc.vpc_id
    subnet_ids = module.vpc.subnet_ids
}

module "rds" {
  source = "./rds"
    vpc_id = module.vpc.vpc_id
    subnet_ids = module.vpc.subnet_ids
}

module "s3" {
  source = "./s3"
}

module "lb" {
  source = "./lb"
}

module "security" {
  source = "./security"
}
