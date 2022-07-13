variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-east-1"
}

variable "vApp" {
  type    = string
  default = "rlv"
}