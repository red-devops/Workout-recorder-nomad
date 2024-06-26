## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.cicd_agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.consul_ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.nomad_client](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.nomad_client_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.nomad_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.vault_ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.db_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.db_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nomad_client_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nomad_client_public_engress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [terraform_remote_state.network](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | Region where to build infrastructure | `string` | n/a | yes |
| <a name="input_team"></a> [team](#input\_team) | Name of the team | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cicd_ec2_sg_id"></a> [cicd\_ec2\_sg\_id](#output\_cicd\_ec2\_sg\_id) | The ID of CICD ec2 security group |
| <a name="output_consul_ec2_sg_id"></a> [consul\_ec2\_sg\_id](#output\_consul\_ec2\_sg\_id) | The ID of consul ec2 security group |
| <a name="output_db_sg_id"></a> [db\_sg\_id](#output\_db\_sg\_id) | The ID of db security group |
| <a name="output_lambda_sg_id"></a> [lambda\_sg\_id](#output\_lambda\_sg\_id) | The ID of lambda security group |
| <a name="output_nomad_client_public_sg_id"></a> [nomad\_client\_public\_sg\_id](#output\_nomad\_client\_public\_sg\_id) | The ID of nomad client public security group |
| <a name="output_nomad_client_sg_id"></a> [nomad\_client\_sg\_id](#output\_nomad\_client\_sg\_id) | The ID of nomad client security group |
| <a name="output_nomad_server_sg_id"></a> [nomad\_server\_sg\_id](#output\_nomad\_server\_sg\_id) | The ID of nomad server security group |
| <a name="output_vault_ec2_sg_id"></a> [vault\_ec2\_sg\_id](#output\_vault\_ec2\_sg\_id) | The ID of vault ec2 security group |
