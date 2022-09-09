
#===================Elastic-IP=============================#

resource "aws_eip" "eip" {
  count = length(var.public_subnet_cidrs)
  vpc   = true
  tags = {
    Name = "${var.env}-gw-${count.index + 1}"
  }
}

resource "aws_eip_association" "eip_assoc" {
  count         = length(aws_eip.eip[*].id)
  instance_id   = element(aws_instance.app_server[*].id, count.index)
  allocation_id = element(aws_eip.eip[*].id, count.index)
}

#=====================User Data===========================#

data "ct_config" "config" {
  content = templatefile("${path.module}/cfg.tpl", {
    key  = var.ssh_key
    user = var.user
  })
  strict = true
}

#=====================instance=============================#


resource "aws_instance" "app_server" {
  ami                    = var.instance_ami
  instance_type          = "t2.micro"
  user_data              = data.ct_config.config.rendered
  vpc_security_group_ids = [var.webserver_sg_id]
  count                  = length(var.public_subnet_ids)
  subnet_id              = element(var.public_subnet_ids, count.index)
  lifecycle {
    create_before_destroy = true
  }
}
