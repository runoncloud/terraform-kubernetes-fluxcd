variable "namespace" {
  description = "The namespace in which Flux CD will be deployed."
  type        = string
  default     = "flux"
}

variable "flux_helm_chart_version" {
  description = "The version of the helm chart for Flux."
  type        = string
  default     = "1.3.0"
}

variable "gir_url" {
  description = "URL of git repo with Kubernetes manifests."
  type        = string
}

variable "gir_branch" {
  description = "Branch of git repo to use for Kubernetes manifests."
  type        = string
  default     = "master"
}

variable "env_secret_name" {
  description = "Name of the secret that contains environment variables which should be defined in the Flux container (using envFrom)."
  type        = string
  default     = null
}

variable "git_auth_key" {
  description = "Git access token."
  type        = string
  default     = null
}

variable "git_user" {
  description = "The Git username the token (git_authkey) belongs to."
  type        = string
  default     = null
}