resource "aws_instance" "nomad_servers" {
  count                = 3
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = "t3.micro"
  subnet_id            = local.subnet_ids[count.index]
  iam_instance_profile = aws_iam_instance_profile.nomad_server_profile.id
  key_name             = "nomad_${terraform.workspace}_key"

  vpc_security_group_ids = [
    data.terraform_remote_state.security_group.outputs.nomad_server_sg_id
  ]

  user_data = templatefile(
    "${path.root}/templates/user-data.sh",
    {
      env    = "${terraform.workspace}",
      server = true,
      public = false
    }
  )

  tags = merge(local.tags, {
    ostype   = "linux",
    Name     = "nomad-server-${count.index + 1}-${terraform.workspace}",
    function = "nomad-server"
  })
}

resource "time_sleep" "wait_5_minutes" {
  depends_on      = [aws_instance.nomad_servers]
  create_duration = "5m"
}