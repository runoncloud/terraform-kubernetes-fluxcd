# Terraform Flux CD Module

This modules make it easy to set up a fresh installation of Flux CD in your Kubernetes cluster.

## Compatibility

This module is meant for use with Terraform >= 0.12.20 If you haven't [upgraded](https://www.terraform.io/upgrade-guides/0-12.html).

## Usage
You can go to the examples folder, however the usage of the module could be like this in your own `main.tf` file:

```hcl
module "flux" {
  source = "../../"

  namespace = "flux"
  gir_url   = "git@github.com:fluxcd/flux-get-started"
}
```

The module currently only support installation for public Git repo or private Git repo accessible over HTTPS. See the [Flux with git over HTTPS](https://hub.helm.sh/charts/fluxcd/flux) documentation for more details.
