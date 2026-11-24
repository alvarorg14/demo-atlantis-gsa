variable "project_id" {
  description = "GCP project where the service account is created."
  type        = string
}

variable "name" {
  description = "Service account ID."
  type        = string
}

variable "display_name" {
  description = "Display name of the service account."
  type        = string
}

variable "description" {
  description = "Description of the service account."
  type        = string
  default     = "Managed by Terraform through Atlantis"
}

variable "roles" {
  description = "Project IAM roles to grant to the service account."
  type        = list(string)
  default     = []
}
