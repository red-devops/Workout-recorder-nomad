resource "aws_security_group" "cicd_agent" {
  name        = "${local.name}-cicd-agent"
  description = "CICD agent security group"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  egress = [
    local.allow_ssh,
    local.allow_https,
    local.allow_8200,
    local.allow_8500,
    local.allow_4646
  ]

  tags = local.tags
}

resource "aws_security_group" "db" {
  name        = "${local.name}-db"
  description = "DB security group"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id
  tags = merge(local.tags, {
    Name = "${local.name}-db"
  })
}

resource "aws_security_group_rule" "db_ingress" {
  security_group_id = aws_security_group.db.id
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = [data.terraform_remote_state.network.outputs.vpc_cidr_block]
}

resource "aws_security_group_rule" "db_egress" {
  security_group_id = aws_security_group.db.id
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  type              = "egress"
  cidr_blocks       = [data.terraform_remote_state.network.outputs.vpc_cidr_block]
}

resource "aws_security_group" "vault_ec2" {
  name        = "${local.name}-vault"
  description = "Vault Server security group"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress = [
    local.allow_8200,
    local.allow_8201,
    local.allow_ssh
  ]
  egress = [
    local.allow_ssh,
    local.allow_http,
    local.allow_https
  ]

  tags = merge(local.tags, {
    Name = "${local.name}-vault-ec2"
  })
}

resource "aws_security_group" "consul_ec2" {
  name        = "${local.name}-consul"
  description = "Consul server security group"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress = [
    local.allow_all,
    local.allow_all_udp
  ]
  egress = [
    local.allow_all,
    local.allow_all_udp
  ]

  tags = merge(local.tags, {
    Name = "${local.name}-consul-ec2"
  })
}

resource "aws_security_group" "lambda" {
  name        = "${local.name}-lambda"
  description = "Lambda security group"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  egress = [
    merge(
      local.allow_mysql,
      { cidr_blocks = data.terraform_remote_state.network.outputs.database_subnets_cidr_blocks }
    ),
    local.allow_http,
    local.allow_https,
    local.allow_8200
  ]

  tags = merge(local.tags, { Name = "${local.name}-lambda" })
}

resource "aws_security_group" "nomad_server" {
  name        = "${local.name}-nomad-server"
  description = "Nomad server security group"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress = [
    local.allow_ssh,
    local.allow_4646,
    local.allow_4647,
    local.allow_4648,
    local.allow_4648_udp,
    local.allow_8300,
    local.allow_8301
  ]

  egress = [
    local.allow_http,
    local.allow_https,
    local.allow_4646,
    local.allow_4647,
    local.allow_4648,
    local.allow_4648_udp,
    local.allow_8200,
    local.allow_8300,
    local.allow_8301,
    local.allow_8301_udp,
    local.allow_8500
  ]

  tags = merge(local.tags, {
    Name = "${local.name}-nomad-server"
  })
}

resource "aws_security_group" "nomad_client" {
  name        = "${local.name}-nomad-client"
  description = "Nomad client security group"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress = [
    local.allow_ssh,
    local.allow_4646,
    local.allow_4647,
    local.allow_8300,
    local.allow_8301
  ]

  egress = [
    local.allow_http,
    local.allow_https,
    merge(
      local.allow_mysql,
      { security_groups = [aws_security_group.db.id] }
    ),
    local.allow_4647,
    local.allow_8200,
    local.allow_8300,
    local.allow_8301,
    local.allow_8301_udp,
    local.allow_8500
  ]

  tags = merge(local.tags, {
    Name = "${local.name}-nomad-client"
  })
}

resource "aws_security_group" "nomad_client_public" {
  name        = "${local.name}-nomad-client-public"
  description = "Nomad client security group"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress = [
    local.allow_ssh,
    local.allow_4646,
    local.allow_4647,
    local.allow_8300,
    local.allow_8301,
    local.allow_9998,
    local.allow_9999
  ]

  egress = [
    local.allow_http,
    local.allow_https,
    local.allow_4647,
    local.allow_8200,
    local.allow_8300,
    local.allow_8301,
    local.allow_8301_udp,
    local.allow_8500,
  ]


  tags = merge(local.tags, {
    Name = "${local.name}-nomad-client-public"
  })
}

resource "aws_security_group_rule" "nomad_client_public_engress" {
  security_group_id        = aws_security_group.nomad_client_public.id
  from_port                = 20000
  to_port                  = 32000
  protocol                 = "tcp"
  type                     = "egress"
  source_security_group_id = aws_security_group.nomad_client.id
}

resource "aws_security_group_rule" "nomad_client_ingress" {
  security_group_id        = aws_security_group.nomad_client.id
  from_port                = 20000
  to_port                  = 32000
  protocol                 = "tcp"
  type                     = "ingress"
  source_security_group_id = aws_security_group.nomad_client_public.id
}