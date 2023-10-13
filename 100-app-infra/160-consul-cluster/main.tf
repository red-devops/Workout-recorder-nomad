resource "aws_instance" "consul_server" {
  count         = 3
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id = data.terraform_remote_state.network.outputs.private_subnets[
    count.index % length(data.terraform_remote_state.network.outputs.private_subnets)
  ]
  iam_instance_profile = aws_iam_instance_profile.consul_server_profile.name
  key_name             = "consul_${terraform.workspace}_key"

  vpc_security_group_ids = [
    data.terraform_remote_state.security_group.outputs.consul_ec2_sg_id
  ]

  user_data = templatefile(
    "${path.root}/templates/user-data.sh",
    {
      env = "${terraform.workspace}"
    }
  )

  tags = merge(local.tags, {
    ostype = "linux"
  })
}

resource "time_sleep" "wait_5_minutes" {
  depends_on      = [aws_instance.consul_server]
  create_duration = "5m"
}