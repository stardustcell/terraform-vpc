variable "aws_region_name" {
    description = "us_west_region"
    type = string
    default = "us-west-2"
  
}

variable "vpc_cidr" {
    description = "vpc_cidr_ip"
    default = ["10.0.0.0/16"]
  
}

variable "public_subnet" {
    description = "public_sub_cidr"
    type = list(string)
    default = [ "10.0.1.0/24", "10.0.2.0/24" ]
  
}

variable "Private_subnet" {
    description = "Private_sub_cidr"
    type = list(string)
    default = [ "10.0.3.0/24", "10.0.4.0/24" ]
  
}

variable "availability_zone" {
    description = "private_avail_zone"
    type = list(string)
    default = [ "eu-central-1a", "eu-central-1b", "eu-central-1c" ]
  
}

