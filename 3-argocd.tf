# ####################################################
# # Create Argo CD application
# ####################################################
# resource "helm_release" "argocd" {
#   name       = "argocd"
#   repository = "https://argoproj.github.io/argo-helm"
#   chart      = "argo-cd"
#   namespace  = "argocd"
#   create_namespace = true
#   version = "3.35.4"
  
#   # Specify configurations
#   values = [
#     templatefile("${path.module}/argocd/argocd-values.yaml" , {})
#   ]
# }

# resource "null_resource" "password" {
#   provisioner "local-exec" {
#     working_dir = "./argocd"
#     command     = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath={.data.password} | base64 -d > argocd-login.txt"
#   }
# }
