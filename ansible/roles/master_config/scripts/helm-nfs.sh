#!/bin/bash
echo "Adding NFS repository to Helm3"
microk8s helm3 repo add \
    csi-driver-nfs https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts
echo "Updating local Helm3 repo"
microk8s helm3 repo update
echo "Helm install NFS"
microk8s helm3 install csi-driver-nfs csi-driver-nfs/csi-driver-nfs \
        --namespace kube-system \
        --set kubeletDir=/var/snap/microk8s/common/var/lib/kubelet
