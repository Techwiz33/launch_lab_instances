variable "aws_region" {
  description = "The AWS region to deploy the EC2 instance in."
  default   = "us-east-1"
}

# variable "image_id" {
#   description = "AMI image"
#   #default   =  "ami-051f7e7f6c2f40dc1"
#   default  = "ami-0419e9ce56c9a4df9"
# }

variable "ec2_keys" {
  description = "ec2 ssh keys"
  default = "jenkins_ssh_keys"
}

variable "instance_type" {
  description = "instance type for ec2"
  default   =  "t2.micro"
}

variable "launch_ec2_jenkins" {
  default   =  true
  type = bool
}

variable "launch_ec2_nexus" {
  default   =  false
  type = bool
}

variable "launch_ec2_sonarqube" {
  default   =  false
  type = bool
}

variable "launch_ec2_tomcat" {
  default   =  false
  type = bool
}

