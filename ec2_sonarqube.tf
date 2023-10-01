resource "aws_instance" "ec2_sonar" {
  count = var.launch_ec2_sonarqube ? 1 : 0
  #ami = "ami-0557a15b87f6559cf"
  #ami = "ami-08c769c21fa56b051" ## before 26th Sept
  ami = "ami-06932106e687c44c6"
  instance_type = "t2.medium"
  key_name = var.ec2_keys
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  associate_public_ip_address = true
  #user_data = file("${path.root}/scripts/install_sonarqube.sh")

  tags = {
    Name = "ec2_sonarqube"

  }
}

output "ec2_sonar_IPAddress" {
  value = "${aws_instance.ec2_sonar[*].public_ip}"
}