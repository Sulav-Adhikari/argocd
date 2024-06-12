Requirement 
# create a secret for ssh access to github in name space argocd

```yaml
apiVersion: v1
metadata:
  labels:
    argocd.argoproj.io/secret-type: repository
  name: argocd
  namespace: argocd
type: Opaque
stringData:
  sshPrivateKey: |
    -----BEGIN OPENSSH PRIVATE KEY-----

    TOnUs6YztdUtOkTlvctWDDniMgUPTFdHsaPlqlVVt7BHjGuH9GdV5N9rgrMXd/+iIHRpLr

    -----END OPENSSH PRIVATE KEY-----

  url: {{ repo url }}
kind: Secret

```


# create a secret to access the docker hub account in the namespace where application is deployed in my case npx


```yaml
  destination: 
    server: https://kubernetes.default.svc
    namespace: npx #<---namespace#
```
kubectl create secret docker-registry dockerconfigjson -n npx --docker-server=https://index.docker.io/v1/ --docker-username={{ docker_user_name }} --docker-password={{ token }} --docker-email={{ mail }}


# create a secret of git pat token with read write access.




# to get the inital argocd admin login password

```bash
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode
```
