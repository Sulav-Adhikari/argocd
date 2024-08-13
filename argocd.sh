#!/bin/bash 

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/stable/manifests/install.yaml
kubectl create secret docker-registry dockerhub-secret -n argocd \
  --docker-username= \
  --docker-password= \
  --docker-email= \
  --docker-server=https://registry-1.docker.io
