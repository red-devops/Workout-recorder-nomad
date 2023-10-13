resource "aws_iam_role" "nomad_client_role" {
  name = "${local.name}-client-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "RoleForEC2"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "nomad_client_profile" {
  name = "${local.name}-client-profile"
  role = aws_iam_role.nomad_client_role.name
}

resource "aws_iam_policy_attachment" "ec2_policy_attachment" {
  name       = "ec2-read-only-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
  roles      = [aws_iam_role.nomad_client_role.name]
}

resource "aws_iam_policy_attachment" "secrets_manager_policy_attachment" {
  name       = "secrets-manager-read-write-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  roles      = [aws_iam_role.nomad_client_role.name]
}
