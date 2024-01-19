  locals {
  instance_ids = module.ec2_instances[*].instance_ids
}


module "networking" {
  source = "./modules/networking"
  
    region = "eu-west-1"
    cidr_block = "10.0.0.0/16"
    vpc_name = "test"
    cidr_subnet1= "10.0.1.0/24"
    cidr_subnet2= "10.0.2.0/24"
    availability_zone1 = "eu-west-1a"
    availability_zone2 = "eu-west-1b"
    subnet_private1 = "private_subnet1"
    subnet_private2 =  "private_subnet2"
    rt_private = "route_table_studdocu"   
}

module "security_group" {
    source = "./modules/Security_Group"
    sg_name = "studocu_sg"
    description = "security group for our"
    vpc_id = module.networking.vpc_id
    from_port = 80
    to_port = 80
}
module "alb_security_group" {
    source = "./modules/Security_Group"
    sg_name = "alb_studocu_sg"
    description = "security group for our"
    vpc_id = module.networking.vpc_id
    from_port = 443
    to_port = 443
}
module "application_load_balancer" {
  source = "./modules/ALB"
  alb_name = "studocuLB"
  subnet1_id = module.networking.subnet_private1_id
  subnet2_id = module.networking.subnet_private2_id
  certificate_arn = module.route53.acm_certificate_arn
  listener_port = 443
  protocol = "HTTPS"
  target_group_arn = module.target_group.target_group_arn
  path_pattern_values = "/"
  host_header_values = "chiheb..code.studucu.com"
  sg_id = [module.alb_security_group.sg_id]
}
module "ec2_instances" {
  source = "./modules/EC2"
  instance_count = 2 
  ami = "ami-02a66cf05465c373f"
  instance_type = "t2.micro"
  instance_name = "webserver"
  filename = "user-data.txt"
  disable_api_termination = "false"
  volume_size = "10"
  key_name = "chiheb"
  sg_id = module.security_group.sg_id
  subnet_ids = [module.networking.subnet_private1_id,module.networking.subnet_private2_id]
  region = "eu-west-1"
}

module "route53" {
source = "./modules/Route53"
sub_domain_name = "chiheb.code.studucu.com"
type = "CNAME"
ttl = 60
record_name = [module.application_load_balancer.dns_name]
domain_name = "code.studucu.com"
}
 
module "target_group" {
  source = "./modules/Target_Group"
  alb_target_group_name = "studocuTg"
  port = "80"
  protocol = "HTTP"
  target_type = "instance"
  aws_vpc_id = module.networking.vpc_id
  path_health_check = "/"
  servers = 2
  target_ids = module.ec2_instances.instance_ids
  region = "eu-west-1"
  
}