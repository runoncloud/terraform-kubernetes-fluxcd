# ----------------------------------------------------------------------------------------------------------------------
# Module : Flux CD
# Dependencies :
#     - https://www.terraform.io/docs/providers/kubernetes/index.html
#     - https://www.terraform.io/docs/providers/helm/index.html
#     - https://github.com/banzaicloud/terraform-provider-k8s
# ----------------------------------------------------------------------------------------------------------------------
terraform {
  required_version = ">= 0.12.24"
  required_providers {
    kubernetes = ">= 1.11.0"
    helm       = ">= 1.2.0"
  }
}

locals {
  env_secret_name = var.env_secret_name != null ? [var.env_secret_name] : []
}

# ----------------------------------------------------------------------------------------------------------------------
# Namespaces
# ----------------------------------------------------------------------------------------------------------------------
resource "kubernetes_namespace" "flux" {
  metadata {
    name = var.namespace
  }
}

# ----------------------------------------------------------------------------------------------------------------------
# Secrets
# ----------------------------------------------------------------------------------------------------------------------
resource "kubernetes_secret" "flux_git_auth" {
  count = var.git_auth_key != null ? 1 : 0

  metadata {
    name = var.env_secret_name
  }

  data = {
    GIT_AUTHUSER = var.git_user
    GIT_AUTHKEY  = var.git_auth_key
  }
}

# ----------------------------------------------------------------------------------------------------------------------
# Helm Flux release
# ----------------------------------------------------------------------------------------------------------------------
resource "helm_release" "flux" {
  name       = "flux"
  namespace  = var.namespace
  repository = "https://charts.fluxcd.io"
  chart      = "flux"
  version    = var.flux_helm_chart_version

  set {
    name  = "git.url"
    value = var.gir_url
  }

  set {
    name  = "git.branch"
    value = var.gir_branch
  }

  dynamic "set" {
    for_each = local.env_secret_name
    content {
      name  = "env.secretName"
      value = var.env_secret_name
    }
  }

  depends_on = [kubernetes_namespace.flux]
}