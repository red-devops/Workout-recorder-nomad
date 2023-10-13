locals {
  name                   = "nomad-${terraform.workspace}"
  bucket                 = "red-devops-terraform-state"
  consul_token_for_fabio = "consul/fabio_token"

  tags = {
    Name        = local.name
    Environment = terraform.workspace
    Create      = "terraform"
    Team        = var.team
  }

  subnet_ids = [
    data.terraform_remote_state.network.outputs.private_subnets[0],
    data.terraform_remote_state.network.outputs.private_subnets[1],
    data.terraform_remote_state.network.outputs.private_subnets[2]
  ]
}
