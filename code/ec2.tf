provider "aws" {
    region = "us-east-1"
    # this key are take for the test IAM user
    
    access_key = "AKIASE5KRGE4UYBEGBET"
    secret_key = "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"
}

resource "aws_instance" "admin" {
    ami = "ami-04b4f1a9cf54c11d0"
    instance_type = "t2.medium"
    security_groups = [ "default" ]
    key_name = "test"
    root_block_device {
      volume_size = 20
      volume_type = "gp2"
      delete_on_termination = true
    }
    
    tags = {
      Name = "microk8s"
    }
    user_data = <<-EFO
    #!/bin/bash
    sudo snap install microk8s --classic 
    sudo microk8s start
    sudo alias kubectl='microk8s.kubectl'
    EFO
}
