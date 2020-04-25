# purrs


---
### Install required tools

#### Skaffold

```bash
curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
chmod +x skaffold
sudo mv skaffold /usr/local/bin
```

#### kubectl

```bash
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin
```

#### minikube

```bash
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
sudo mv minikube /usr/local/bin
```

#### kustomize

```bash
curl -s https://api.github.com/repos/kubernetes-sigs/kustomize/releases | grep browser_download | grep linux | cut -d '"' -f 4 | grep /kustomize/v | sort | tail -n 1 | xargs curl -O -L
tar -xzvf kustomize*
sudo mv kustomize /usr/local/bin
```

---
