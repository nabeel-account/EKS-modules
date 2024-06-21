#####################################################################################################
# Create a kubeconfig file that is secure and user friendly in a Source code Management (SCM)
#####################################################################################################

# Retrieve information about an EKS Cluster.
data "aws_eks_cluster" "cluster" {
  name = var.cluster_name

  depends_on = [ module.eks ]
}

# Get an authentication token to communicate with an EKS cluster.
data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
  depends_on = [ module.eks ]
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  # token                  = data.aws_eks_cluster_auth.cluster_auth.token
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}