output "nomad_client_public" {
  description = "The public IP addres of nomad clinet"
  value       = aws_instance.nomad_client_public[0].public_ip
}