#!/bin/bash
echo "Creating the namespace to Jupyterhub"
microk8s kubectl create namespace jhub
echo "Adding NFS to repo"
microk8s helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
echo "Updating local NFS repo"
microk8s helm repo update

echo "Deploying Jupyterhub"
microk8s helm install jupyterhub jupyterhub/jupyterhub \
  --namespace jhub \
  --version=2.0.0 \
  --values ../../../../jupyterhub/jupyterhub-config.yaml
