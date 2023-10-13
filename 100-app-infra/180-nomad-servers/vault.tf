resource "vault_policy" "nomad_cluster" {
  name = "nomad-cluster"

  policy = <<EOF

path "auth/token/create/nomad-cluster" {
  capabilities = ["update"]
}

path "auth/token/roles/nomad-cluster" {
  capabilities = ["read"]
}

# Allow looking up incoming tokens to validate they have permissions to access
# the tokens they are requesting. This is only required if
# `allow_unauthenticated` is set to false.
path "auth/token/lookup" {
  capabilities = ["update"]
}

path "auth/token/lookup-accessor" {
  capabilities = ["update"]
}

# Allow revoking tokens that should no longer exist. This allows revoking
# tokens for dead tasks.
path "auth/token/revoke-accessor" {
  capabilities = ["update"]
}

# Allow checking the capabilities of our own token. This is used to validate the
# token upon startup.
path "sys/capabilities-self" {
  capabilities = ["update"]
}

# Allow our own token to be renewed.
path "auth/token/renew-self" {
  capabilities = ["update"]
}
EOF
}

resource "vault_policy" "workoutrecorder" {
  name = "workoutrecorder"

  policy = <<EOF

    path "kv/data/workoutrecorder/*" {
      capabilities = ["read"]
    }
  EOF
}

resource "vault_policy" "fabio" {
  name = "fabio"

  policy = <<EOF

    path "kv/data/consul/fabio_token" {
      capabilities = ["read"]
    }
  EOF
}

resource "vault_token_auth_backend_role" "nomad_cluster_role" {
  role_name              = "nomad-cluster"
  allowed_policies       = ["workoutrecorder", "fabio"]
  orphan                 = true
  token_period           = "259200"
  renewable              = true
  token_explicit_max_ttl = "0"
}

resource "vault_token" "nomad_cluster" {
  display_name    = "nomad-cluster"
  policies        = ["${vault_policy.nomad_cluster.name}"]
  renewable       = true
  no_parent       = true
  ttl             = "0"
  renew_min_lease = 43200
  renew_increment = 86400
}

resource "vault_generic_secret" "nomad_cluster_token" {
  path      = "kv/${local.nomad_cluster_token_for_vault_secret_path}"
  data_json = <<EOT
    {
      "token": "${vault_token.nomad_cluster.client_token}"
    }
  EOT
}
