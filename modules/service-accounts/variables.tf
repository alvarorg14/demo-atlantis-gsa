variable "project_id" {
  description = "GCP project where the service account is created."
  type        = string
}

variable "name" {
  description = "Service account ID."
  type        = string

  validation {
    condition     = length(var.name) >= 6 && length(var.name) <= 30 && can(regex("^demo-[a-z][a-z0-9-]*[a-z0-9]$", var.name))
    error_message = "The account ID must be 6-30 characters and follow the demo-* naming convention."
  }
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
