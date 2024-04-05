# https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name    = var.cluster_name
  cluster_version = "1.27"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets

  # Enable public endpoint
  cluster_endpoint_public_access = true

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t2.micro", "t2.small", "t2.medium"]
  }

  # Kubernetes Addon
  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent = true
    }
  }

  eks_managed_node_groups = {
    default = {
      instance_types = ["t2.large"]
      capacity_type  = "ON_DEMAND"

      min_size     = 1
      max_size     = 2
      desired_size = 1

      # Required for  aws-ebs-csi-driver
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 20
            volume_type           = "gp3"
            iops                  = 3000
            throughput            = 150
            encrypted             = true
            delete_on_termination = true
          }
        }
      }
    }

    # spot = {
    #   instance_types = ["t2.medium"]
    #   capacity_type  = "SPOT"

    #   min_size     = 1
    #   max_size     = 2
    #   desired_size = 1

    #   iam_role_additional_policies = {
    #     AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
    #   }

    #   block_device_mappings = {
    #     xvda = {
    #       device_name = "/dev/xvda"
    #       ebs = {
    #         volume_size           = 20
    #         volume_type           = "gp3"
    #         iops                  = 3000
    #         throughput            = 150
    #         encrypted             = true
    #         delete_on_termination = true
    #       }
    #     }
    #   }
    # }
  }
}