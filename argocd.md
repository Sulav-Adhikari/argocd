
```bash
#!/bin/bash 
#install argocd
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# install argocd image updater
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/stable/manifests/install.yaml
#install argo rollout
kubectl create namespace argo-rollouts
kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml

kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:443

kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode


kubectl create secret docker-registry dockerhub-secret -n argocd \
  --docker-username= \
  --docker-password= \
  --docker-email= \
  --docker-server=https://registry-1.docker.io

kubectl create secret docker-registry dockerhub-secret -n <nameSpaceOnWhichApplicationisbeingDeployed> \
  --docker-username= \
  --docker-password= \
  --docker-email= \
  --docker-server=https://registry-1.docker.io
```

```yaml
    argocd-image-updater.argoproj.io/main.pull-secret: pullsecret:argocd/dockerhub-secret
    
    imagePullSecrets:
     - name : dockerhub-secret
```

```yaml
apiVersion: v1
metadata:
  labels:
    argocd.argoproj.io/secret-type: repository
  name: argocd
  namespace: argocd
type: git
stringData:
  sshPrivateKey: |
    -----BEGIN OPENSSH PRIVATE KEY-----

    -----END OPENSSH PRIVATE KEY-----

  url: git@github.com:Sulav-Adhikari/argocd.git
kind: Secret

```

```yaml
    argocd-image-updater.argoproj.io/write-back-method: git:secret:argocd/argocd #namspace/secretname 
```