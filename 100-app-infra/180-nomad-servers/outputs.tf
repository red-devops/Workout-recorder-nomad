output "nomad_private_ip" {
  description = "The private IP of nomad host"
  value       = aws_instance.nomad_servers[0].private_ip
}
