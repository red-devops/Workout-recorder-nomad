output "cicd_ec2_sg_id" {
  description = "The ID of CICD ec2 security group"
  value       = aws_security_group.cicd_agent.id
}

output "db_sg_id" {
  description = "The ID of db security group"
  value       = aws_security_group.db.id
}

output "vault_ec2_sg_id" {
  description = "The ID of vault ec2 security group"
  value       = aws_security_group.vault_ec2.id
}

output "consul_ec2_sg_id" {
  description = "The ID of consul ec2 security group"
  value       = aws_security_group.consul_ec2.id
}

output "lambda_sg_id" {
  description = "The ID of lambda security group"
  value       = aws_security_group.lambda.id
}

output "nomad_server_sg_id" {
  description = "The ID of nomad server security group"
  value       = aws_security_group.nomad_server.id
}

output "nomad_client_sg_id" {
  description = "The ID of nomad client security group"
  value       = aws_security_group.nomad_client.id
}

output "nomad_client_public_sg_id" {
  description = "The ID of nomad client public security group"
  value       = aws_security_group.nomad_client_public.id
}

# output "fabio_ec2_sg_id" {
#   description = "The ID of fabio security group"
#   value       = aws_security_group.fabio.id
# }
# output "frontend_ec2_sg_id" {
#   description = "The ID of frontend ec2 security group"
#   value       = aws_security_group.frontend_ec2.id
# }

# output "backend_ec2_sg_id" {
#   description = "The ID of frontend ec2 security group"
#   value       = aws_security_group.backend_ec2.id
# }
