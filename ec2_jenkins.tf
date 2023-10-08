resource "aws_instance" "ec2_jenkins" {
  count = var.launch_ec2_jenkins ? 1 : 0
  #ami = "ami-083b355a397a1763c"
  #ami = "ami-062c448666d748884"  ##  before sept 26th
  ami = "ami-0df8aa15ac33a9c53"
  instance_type = "t2.medium"
  key_name = var.ec2_keys
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  associate_public_ip_address = true

  user_data = "${file("${path.root}/scripts/start_jenkins.sh")}"
  tags = {
    Name = "ec2_jenkins"

  }
}

output "ec2_Jenkins_IPAddress" {
  value = "${aws_instance.ec2_jenkins[*].public_ip}"
}