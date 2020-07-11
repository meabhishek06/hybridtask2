resource "aws_instance" "wordpress" {
  ami = "ami-052c08d70def0ac62"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public.id}"
  vpc_security_group_ids = ["${aws_security_group.sg_public.id}"]
  key_name = "linuxlw"
 tags ={
    Name= "wordpress"
  }
depends_on = [
    aws_route_table_association.public_association,
  ]
}

resource "aws_instance" "mysql" {
  ami = "ami-08706cb5f68222d09"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.private.id}"
  vpc_security_group_ids = ["${aws_security_group.sg_private.id}"]
  key_name = "linuxlw"
 tags ={
    Name= "mysql"
  }
depends_on = [
    aws_route_table_association.public_association,
  ]
}

