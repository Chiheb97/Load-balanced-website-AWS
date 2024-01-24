variable "region" {
  description = "Region for Resources"
}

variable "tags" {
  description = "Tags."
  type        = map(string)
  default     = null
}


variable "alb_target_group_name" {
  description = "target group name"
}

variable "aws_vpc_id" {
  description = "vpc id"
}

variable "protocol" {
  description = "the protocol to use http / tcp /"
}


variable "target_type" {
  description = " (May be required, Forces new resource) Type of target that you must specify when registering targets with this target group."
  default = null
  }
  variable "port" {

  }
  variable "servers"{
    
  }
 

variable "target_ids" {
  type    = list(string)
}