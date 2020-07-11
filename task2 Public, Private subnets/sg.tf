resource "aws_security_group" "sg_public" {
  name        = "sg_public"
  description = "sg_public"
  vpc_id      = "${aws_vpc.create_vpc.id}"

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 /* ingress {
    description = "sg_private"
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }*/
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "sg_public"
  }
}

resource "aws_security_group" "sg_private" {
  name        = "sg_private"
  description = "sg_private"
  vpc_id      = "${aws_vpc.create_vpc.id}"

  ingress {
    description = "sg_private"
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "sg_private"
  }
}