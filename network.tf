

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = join("-", [var.vApp,"vpc"])
  cidr = "10.2.0.0/16"



  azs            = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets = ["10.2.0.0/24","10.2.1.0/24","10.2.2.0/24"]
  # private_subnets  = ["10.0.10.0/24","10.0.20.0/24","10.0.30.0/24"]

  # enable_nat_gateway = true
  # enable_vpn_gateway = true

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

}

#Get all available AZ's in VPC for master region
data "aws_availability_zones" "azs" {
  state = "available"
}


resource "aws_ssm_parameter" "public_subnet_id_a" {
  name  = join("-", [var.vApp, "PubSubA_ID"])
  type  = "String"
  value = module.vpc.public_subnets[0]
}

resource "aws_ssm_parameter" "public_subnet_id_b" {
  name  = join("-", [var.vApp, "PubSubB_ID"])
  type  = "String"
  value = module.vpc.public_subnets[1]
}

resource "aws_ssm_parameter" "public_subnet_id_c" {
  name  = join("-", [var.vApp, "PubSubC_ID"])
  type  = "String"
  value = module.vpc.public_subnets[2]
}

resource "aws_ssm_parameter" "public_subnet_a" {
  name  = join("-", [var.vApp, "PubSubA"])
  type  = "String"
  value = module.vpc.public_subnets_cidr_blocks[0]
}

resource "aws_ssm_parameter" "public_subnet_b" {
  name  = join("-", [var.vApp, "PubSubB"])
  type  = "String"
  value = module.vpc.public_subnets_cidr_blocks[1]
}

resource "aws_ssm_parameter" "public_subnet_c" {
  name  = join("-", [var.vApp, "PubSubC"])
  type  = "String"
  value = module.vpc.public_subnets_cidr_blocks[2]
}

resource "aws_ssm_parameter" "vpc_id" {
  name  = join("-", [var.vApp, "VpcId"])
  type  = "String"
  value = module.vpc.vpc_id
}