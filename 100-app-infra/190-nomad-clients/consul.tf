resource "consul_acl_token" "nomad_client" {
  description = "Token for Nomad Client"
  policies    = ["${consul_acl_policy.nomad_client.name}", "${consul_acl_policy.read_workoutrecorder_config.name}"]
}

resource "consul_acl_policy" "nomad_client" {
  name        = "nomad-client"
  description = "Policy for Nomad Client"
  rules       = <<-RULE
    agent_prefix "" {
      policy = "read"
    }

    node_prefix "" {
      policy = "read"
    }

    service_prefix "" {
      policy = "read"
    }

    service_prefix "nomad-client" {
      policy = "write"
    }

    service "workoutrecorder-backend" {
      policy = "write"
    }

    service "workoutrecorder-frontend" {
      policy = "write"
    }

    RULE
}

resource "consul_acl_token" "consul_agent" {
  description = "Token for Consul agent on Nomad Client"
  policies    = ["${consul_acl_policy.consul_agent.name}"]
}

resource "consul_acl_policy" "consul_agent" {
  name        = "consul-agent-for-nomad-client"
  description = "Policy for Consul agent on Nomad Client"
  rules       = <<-RULE
    service_prefix "nomad-client" {
      policy = "write"
    }

    service_prefix "" {
    policy = "read"
    }

    node_prefix "nomad-client" {
    policy = "write"
    }

    node_prefix "" {
    policy = "read"
    }

    session_prefix "nomad-client" {
    policy = "write"
    }

    agent_prefix "nomad-client" {
    policy = "write"
    }
    RULE
}


resource "consul_acl_policy" "read_workoutrecorder_config" {
  name        = "read-workoutrecorder-config"
  description = "Policy for read workoutrecorder config K/V"
  rules       = <<-RULE
    key_prefix "config/workoutrecorder" {
      policy = "read"
    }
    RULE
}

resource "consul_acl_token" "fabio_task" {
  description = "Token for fabio task"
  policies    = ["${consul_acl_policy.fabio_task.name}"]
}

resource "consul_acl_policy" "fabio_task" {
  name        = "fabio-task"
  description = "Policy for fabio task"
  rules       = <<-RULE

    service "fabio" {
      policy = "write"
    }

    service_prefix "" {
      policy = "read"
    }

    node_prefix "fabio" {
      policy = "write"
    }

    node_prefix "" {
      policy = "read"
    }

    session "fabio" {
      policy = "write"
    }

    agent "fabio" {
      policy = "write"
    }

    agent_prefix "" {
      policy = "read"
    }
    RULE
}

resource "vault_generic_secret" "consul_token_for_fabio" {
  path      = "kv/${local.consul_token_for_fabio}"
  data_json = <<EOT
    {
      "token": "${data.consul_acl_token_secret_id.read.secret_id}"
    }
  EOT
}