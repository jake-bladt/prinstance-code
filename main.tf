provider "aws" {
	region = "us-east-1"
}	

resource "aws_launch_configuration" "prinstance_launch_config" {
	name = "PR Instance launch configuration"
	placement_group           = "aws_placement_group.prinstance_pg.id"
	instance_type             = "t2.medium"
	image_id                  = "ami-07ebfd5b3428b6f4d"
	key_name                  = "tops"
	root_block_device         = [{
		volume_type  = "gp2"
		volume_suze  = 40
	}]
}

resource "aws_placement_group" "prinstance_pg" {
	name       = "prinstance"
	strategy   = "cluster"
}

resource "aws_autoscaling_group" "prinstance_asg" {
	name                      = "prinstance-asg"
	max_size                  =  1
	min_size                  =  1
	health_check_grace_period = 300
	health_check_type         = "ELB"
	desired_capacity          = 1
	force_delete              = true
	launch_configuration      = "${aws_launch_configuration.prinstance_launch_config.name}"
	vpc_zone_identifier       = ["vpc-0c9238c955c71c371"]
}

