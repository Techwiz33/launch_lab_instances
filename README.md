# Terraform - Jenkins,Sonarqube,nexus,tomcat

## How to execute
- Login to AWS management consolse 
- GO to EC2 Service and Create ssh key pair "jenkins_ssh_keys"
- variables.tf - Check the ec2_keys value is "jenkins_ssh_keys"
```
variable "ec2_keys" {
  description = "ec2 ssh keys"
  default = "jenkins_ssh_keys"
}
```
- Select which instances to create by updating the variable value or passing it via tf.vars file. Example to launch jenkins pass the "launch_ec2_jenkins"
```
```
- export AWS Account credentails 
```
export AWS_ACCESS_KEY_ID="XXXXXXXXXXXXXXXXX"
export AWS_SECRET_ACCESS_KEY="XXXXXXXXXXXXXXXX"
```
- Execute terraform 
```
"terraform init"
"terraform plan"
"terraform apply"
```