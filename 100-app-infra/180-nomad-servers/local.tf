locals {
  name                                      = "nomad-${terraform.workspace}"
  bucket                                    = "red-devops-terraform-state"
  nomad_cluster_token_for_vault_secret_path = "nomad/vault_token"

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
