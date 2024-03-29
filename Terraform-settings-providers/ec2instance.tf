#create ec2 instance resource
resource "aws_instance" "myec2" {
  ami           = data.aws_ami.amzlinux2.id 
  instance_type = var.instance_type
  #Reference List values
  #instance_type = var.instance_type_list[1]
  
  #Reference map values
  #instance_type = var.instance_type_map["dev"]

  key_name = var.instance_keypair
  user_data     = file("${path.module}/apache.sh")
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  # Meta-Argument Count
  count = 2 #number of ec2 instance to be provisioned
  # count.index
  tags = {
    "Name" = "test-ec2-${count.index}"
  }

}
