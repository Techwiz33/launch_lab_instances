resource "aws_instance" "ec2_app" {
  count = var.launch_ec2_app ? 1 : 0
  ami = "ami-05fa00d4c63e32376"
  instance_type = "t2.minor"
  key_name = var.ec2_keys
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "ec2_app"

  }
}

output "ec2_tomcat_ip_address" {
  value = "${aws_instance.ec2_app[*].public_ip}"
}