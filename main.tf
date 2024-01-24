  locals {
  instance_ids = module.ec2_instances[*].instance_ids
}


module "networking" {
  source = "./modules/networking"
  
    region = "eu-west-1"
    cidr_block = "10.0.0.0/16"
    vpc_name ="studocuvpc"
    cidr_subnet1= "10.0.1.0/24"
    cidr_subnet2= "10.0.2.0/24"
    availability_zone1 = "eu-west-1a"
    availability_zone2 = "eu-west-1b"
    subnet_private1 = "private_subnet1"
    subnet_private2 =  "private_subnet2"
    rt_private = "route_table_studdocu" 
    cidr_subnet_pub = "10.0.3.0/24"  
    cidr_subnet_pub2 = "10.0.4.0/24" 
    igw_name = "studdocu_igw"
    subnet_public_name = "studdocu_public1_subnet"
    subnet_public_name2 = "studdocu_public2_subnet"
}

module "security_group" {
    source = "./modules/Security_Group"
    vpc_id = module.networking.vpc_id
    
}
module "application_load_balancer" {
  source = "./modules/ALB"
  alb_name = "studocuLB"
  subnet1_id = module.networking.subnet_public
  subnet2_id = module.networking.subnet_public2
  certificate_arn = module.route53.acm_certificate_arn
  listener_port = 443
  protocol = "HTTPS"
  target_group_arn = module.target_group.target_group_arn
  path_pattern_values = ["/"]
  host_header_values = ["chiheb.code.studuku.com"]
  sg_id = [module.security_group.alb_sg]
  depends_on = [module.route53.acm_certificate_validation]
}
module "ec2_instances" {
  source = "./modules/EC2"
  instance_count = 2 
  ami = "ami-02a66cf05465c373f"
  
  instance_type = "t3.micro"
  instance_name = "webserver-chiheb"
  filename = filebase64("${path.module}/user-data1.sh")
  disable_api_termination = "false"
  volume_size = "10"
  key_name = "chiheb"
  sg_id = module.security_group.sg_id_ec2
  subnet_ids = [module.networking.subnet_public,module.networking.subnet_public2]
  region = "eu-west-1"
}

 module "route53" {
source = "./modules/Route53"
sub_domain_name = "chiheb"
record = module.application_load_balancer.dns_name
domain_name = "studuku.com"
subdomain = "chiheb.code"
} 
 
module "target_group" {
  source = "./modules/Target_Group"
  alb_target_group_name = "studocuTg"
  port = "80"
  protocol = "HTTP"
  target_type = "instance"
  aws_vpc_id = module.networking.vpc_id
  servers = 2
  target_ids = module.ec2_instances.instance_ids
  region = "eu-west-1"  
}
