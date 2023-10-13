resource "aws_instance" "nomad_client" {
  count                = 2
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = "t3.micro"
  subnet_id            = local.subnet_ids[count.index]
  iam_instance_profile = aws_iam_instance_profile.nomad_client_profile.id
  key_name             = "nomad_${terraform.workspace}_key"

  vpc_security_group_ids = [
    data.terraform_remote_state.security_group.outputs.nomad_client_sg_id
  ]

  user_data = templatefile(
    "${path.root}/templates/user-data.sh",
    {
      env    = "${terraform.workspace}",
      server = false,
      public = false
    }
  )

  tags = merge(local.tags, {
    ostype   = "linux",
    Name     = "nomad-client-${count.index + 1}-${terraform.workspace}"
    public   = false
    function = "nomad-client"
  })
}

resource "aws_instance" "nomad_client_public" {
  count                = 1
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = "t3.micro"
  subnet_id            = data.terraform_remote_state.network.outputs.public_subnets[0]
  iam_instance_profile = aws_iam_instance_profile.nomad_client_profile.id
  key_name             = "nomad_${terraform.workspace}_key"

  associate_public_ip_address = true

  vpc_security_group_ids = [
    data.terraform_remote_state.security_group.outputs.nomad_client_public_sg_id
  ]

  user_data = templatefile(
    "${path.root}/templates/user-data.sh",
    {
      env    = "${terraform.workspace}",
      server = false,
      public = true
    }
  )

  tags = merge(local.tags, {
    ostype   = "linux",
    Name     = "nomad-client-public-${count.index + 1}-${terraform.workspace}"
    public   = true
    function = "nomad-client"
  })
}
