variable "region" {
  description = "Region for Resources"
  }

variable "tags" {
  description = "Tags."
  type        = map(string)
  default     = null
}

variable "subnet_private1" {
  description = "name of subnet private 1"
  }
variable "subnet_private2" {
  description = "name of subnet private 2"
  } 

variable "rt_private" {
  description = "name of route table private"
  } 
   variable "cidr_subnet1" {
  description = "subnet cidr block"
  } 
   variable "cidr_subnet2" {
  description = "subnet cidr block"
  } 
   variable "cidr_block" {
  description = "subnet cidr block"
  } 
  variable "availability_zone2"{

  }
  variable "availability_zone1"{
    
  }
  variable "vpc_name"{
    
  }
 variable  "igw_name"{

 }
 variable "cidr_subnet_pub"{

 }
 variable "subnet_public_name"{

 }
  variable "cidr_subnet_pub2"{

 }
 variable "subnet_public_name2"{
  
 }