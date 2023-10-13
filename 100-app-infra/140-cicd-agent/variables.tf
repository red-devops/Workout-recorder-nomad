variable "region" {
  description = "Region where to build infrastructure"
  type        = string
}

variable "team" {
  description = "Name of the team"
  type        = string
}

variable "github_agent_ami" {
  description = "GitHub agent AMI based on workspace"
  type        = map(string)
}