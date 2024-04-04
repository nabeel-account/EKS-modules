# Create namespace

resource "kubernetes_namespace" "development_namespace" {
  metadata {
    name = "development"
  }
}