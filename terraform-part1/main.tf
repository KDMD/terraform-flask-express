resource "aws_instance" "app_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  #security_groups = [aws_security_group.app_sg.name] # for default vpc if available

# Function "file" expects only 1 argument(s).
  user_data = templatefile("${path.module}/scripts/userdata.sh.tpl", {
    mongo_url   = var.mongo_url
    backend_url = var.backend_url
  })

  user_data_replace_on_change = true


  tags = {
    Name = "Flask-Express-Ubuntu-Server"
  }
}