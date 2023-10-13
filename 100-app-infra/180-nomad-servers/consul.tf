resource "consul_acl_token" "nomad_server" {
  description = "Token for Nomad Server"
  policies    = ["${consul_acl_policy.nomad_server.name}"]
}

resource "consul_acl_policy" "nomad_server" {
  name        = "nomad-server"
  description = "Policy for Nomad Server"
  rules       = <<-RULE
    agent_prefix "" {
      policy = "read"
    }

    node_prefix "" {
      policy = "read"
    }

    service_prefix "" {
      policy = "write"
    }

    acl = "write"
    RULE
}

resource "consul_acl_token" "consul_agent" {
  description = "Token for Consul agent on Nomad Server"
  policies    = ["${consul_acl_policy.consul_agent.name}"]
}

resource "consul_acl_policy" "consul_agent" {
  name        = "consul-agent-for-nomad-server"
  description = "Policy for Consul agent on Nomad Server"
  rules       = <<-RULE
    service_prefix "nomad-server" {
      policy = "write"
    }

    service_prefix "" {
    policy = "read"
    }

    node_prefix "nomad-server" {
    policy = "write"
    }

    node_prefix "" {
    policy = "read"
    }

    session_prefix "nomad-server" {
    policy = "write"
    }

    agent_prefix "nomad-server" {
    policy = "write"
    }
    RULE
}
