#!/bin/bash

# Cretae ResourceGroup
az group create -n {Name} -l canadaeast

# Create Kubernetes Cluster
az aks create -g kubernetes -n smrtcluster --node-count 1 --enable-addons monitoring --generate-ssh-keys

# Get the Credentials of the Cluster
az aks get-credentials -g kubernetes -n smrtcluster

# Get the Nodes Running in the Cluster
kubectl get nodes

# Apply the application Configuration File
kubectl apply -f akubernetesApp.yml

# Get the Pods Running in Kubernetes
kubectl get pods

# Apply the Service Configuration File
kubectl apply -f kubernetesService.yml

# Get the List of Services Running in Kubernetes
kubectl get services


#*** Extra: Create Persistant Disk for the Nodes ***

# Show the Resource Groups that Attached to the Nodes of the Cluster
az aks show -g kubernetes -n smrtcluster --query nodeResourceGroup -o tsv

# Create Disk in the Same Resource Group of Nodes
#az disk create -g {PreviousCommandOutput} -n {NameofDisk} --size-gb {Size} --query id --output tsv
az disk create -g MC_... -n smrtclusterdisk --size-gb 20 --query id -o tsv