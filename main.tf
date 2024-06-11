resource "aws_db_instance" "database" {
  identifier          = lower(replace(var.db_name, "/[^a-z0-9]/", "-"))
  allocated_storage   = 20 # Tamanho em GB
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t3.micro"
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true
  publicly_accessible = false
}

resource "aws_instance" "web_server" {
  ami           = "ami-0c4f502a03074cd85"
  instance_type = var.instance_type
  tags = {
    Name = "web-server"
  }

  # Script de inicialização
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd php mysql
              systemctl start httpd
              systemctl enable httpd
              echo "<?php phpinfo(); ?>" > /var/www/html/index.php
              EOF
}

resource "aws_security_group" "mysql_access" {
  name        = "mysql_access"
  description = "Permite acesso ao MySQL"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
