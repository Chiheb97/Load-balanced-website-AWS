

variable "ami" {
  description = "ami of instance"
  type        = string
}

variable "instance_name" {
  description = "Name of instance"
  type        = string
}
variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "key_name" {
  description = "key pair name"
  type        = string
}
variable "sg_id" {
  description = "security group id"
}
variable "subnet_ids" {
  type    = list(string)
  default = ["subnet-1", "subnet-2"]
}

variable "filename" {
  description = "the name of file of user-data configuration with .txt extention  "
}
variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection. "
}


variable "volume_size" {
  description = "Size of the volume in gibibytes "
}

variable "region" {
  description = "Region for Resources"
}

variable "instance_count"{
    description = "number of instances to launch"
    type = number
}