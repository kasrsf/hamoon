variable "aws_profile_name" {
  description = "AWS profile to use"
  type        = string
  default     = null
}

variable "region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-2"
}
