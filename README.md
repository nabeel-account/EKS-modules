# Kubernetes inftrustructure

## How does it work?

This repository will create the networking and EKS infrustructure when applied.

Once you've terraform applied the resources, you must add update your local kube-configuration by running the following:
`aws eks --region us-east-1 update-kubeconfig --name main-cluster`

please update the region or cluster name if the defaults were changed.

## More information

You can find the modules used in this repository in from https://github.com/terraform-aws-modules

An example of manual deployment of Kubernetes EKS can be found here: https://medium.com/@CloudTopG/the-simplest-way-to-create-an-aws-eks-cluster-using-terraform-4ee5ba2e9ddc

