locals {
  name = "actions-runner-controller"

  default_helm_config = {
    name             = local.name
    chart            = local.name
    repository       = "https://actions-runner-controller.github.io/actions-runner-controller"
    version          = "0.21.1"
    namespace        = "actions-runner-system"
    create_namespace = true
    values           = local.default_helm_values
    set              = []
    description      = "The Actions Runner Controller (ARC) deployment configuration"
    wait             = false
  }

  default_helm_values = [templatefile("${path.module}/values.yaml", {})]

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  argocd_gitops_config = {
    enable = true
  }
}
