provider "aws" {
	region = "us-east-1"
}	

resource "aws_instance" "prinstance_host" {
	instance_type = "t2.micro"
	ami           = "ami-07ebfd5b3428b6f4d"
}

