resource "aws_instance" "workstation"{
    ami = data.aws_ami.rhel9_devops.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [ aws_security_group.allow-workstation.id]
    user_data = file("workstation.sh")
    root_block_device {
    volume_size = 20  # Set the EBS volume size to 30GB
    volume_type = "gp3"  # (Optional) Choose volume type (gp2, gp3, io1, etc.)
    }
    tags ={
        Name = "workstation"
    }
}

resource "aws_security_group" "allow-workstation" {

    name = "allow-all-workstation"
    description = "it allows everyone"
    ingress{
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
        

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
}

data "aws_ami" "rhel9_devops" {
  owners      = ["973714476881"] # Owner ID from AWS CLI output
  most_recent = true             # Ensures you get the latest AMI

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }
}