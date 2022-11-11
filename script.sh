#!/usr/bin/env bash

#argocd default password
kubectl get secret -n argocd argocd-initial-admin-secret -o yaml

#login to argocd
./argocd-linux-amd64 login 172.18.0.4:32036
./argocd-linux-amd64 account update-password
./argocd-linux-amd64 app list
./argocd-linux-amd64 app diff argocd/nginx
./argocd-linux-amd64 app sync argocd/nginx
./argocd-linux-amd64 app history argocd/nginx
./argocd-linux-amd64 app get argocd/nginx
./argocd-linux-amd64 app set argocd/nginx --auto-prune --sync-policy automatic --self-heal

k3d cluster create dev-cluster --k3s-arg '--tls-san=192.168.0.235@server:0' --config dev-cluster-config.yaml

$ kubectl cluster-info
Kubernetes control plane is running at https://192.168.0.235:42621

./argocd-linux-amd64 proj create dev -d https://192.168.0.235:42621,nginx2 -s https://github.com/frost52/argocd-test.git
./argocd-linux-amd64 app edit argocd/nginx
./argocd-linux-amd64 app patch argocd/nginx --patch '{"destination": {"namespace":"nginx"}}' --type merge

docker build -f Dockerfile -t yorge/hello:v1 .
docker login
docker push yorge/hello:v1
kubectl create secret -n nginx2 docker-registry regcred --docker-server=https://index.docker.io/v2/ --docker-username=username --docker-passwod=password

docker build -f Dockerfile -t yorge/hello:v2 .
docker push yorge/hello:v2

