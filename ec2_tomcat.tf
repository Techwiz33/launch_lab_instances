resource "aws_instance" "ec2_tomcat" {
  count = var.launch_ec2_tomcat ? 1 : 0
  ami = "ami-05fa00d4c63e32376"
  instance_type = "t2.minor"
  key_name = var.ec2_keys
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  associate_public_ip_address = true

  #user_data = "${file("${path.root}/scripts/install_tomcat.sh")}"

  tags = {
    Name = "ec2_tomcat"

  }
}

output "ec2_tomcat_ip_address" {
  value = "${aws_instance.ec2_tomcat[*].public_ip}"
}