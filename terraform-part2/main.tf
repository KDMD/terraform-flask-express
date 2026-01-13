resource "aws_instance" "backend" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.backend_sg.id]

  user_data = templatefile(
    "${path.module}/scripts/userdata-backend.sh.tpl",
    { mongo_url = var.mongo_url }
  )

  tags = { Name = "Flask-Backend" }
}

resource "aws_instance" "frontend" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]

  user_data = templatefile(
    "${path.module}/scripts/userdata-frontend.sh.tpl",
    {
      backend_url = "http://${aws_instance.backend.private_ip}:5000"
    }
  )

  tags = { Name = "Express-Frontend" }
}
