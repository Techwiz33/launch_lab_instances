resource "aws_instance" "ec2_nexus" {
  count = var.launch_ec2_nexus ? 1 : 0
  ami = "ami-05fa00d4c63e32376"
  instance_type = "t2.medium"
  key_name = var.ec2_keys
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  associate_public_ip_address = true

  user_data = "${file("${path.root}/scripts/install_nexus.sh")}"

  tags = {
    Name = "ec2_nexus"

  }
}

output "ec2_nexus_IPAddress" {
  value = "${aws_instance.ec2_nexus[*].public_ip}"
}