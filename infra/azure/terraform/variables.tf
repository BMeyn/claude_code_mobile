variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure location"
  default     = "westeurope"
}

variable "project_name" {
  type        = string
  description = "Project/app name prefix"
  default     = "claude-code"
}

variable "container_app_name" {
  type        = string
  description = "Azure Container App name"
  default     = "claude-container-app"
}

variable "container_image" {
  type        = string
  description = "Full container image (e.g., myacr.azurecr.io/backend:tag)"
}

variable "target_port" {
  type        = number
  description = "Container port"
  default     = 3000
}

variable "min_replicas" {
  type        = number
  default     = 0
}

variable "max_replicas" {
  type        = number
  default     = 5
}
