helm repo add jetstack https://charts.jetstack.io --force-update

helm install porkbun-webhook ./deploy/porkbun-webhook \
--set groupName=porkbun-webhook -n cert-manager

kubectl create secret generic porkbun-key -n cert-manager \
--from-literal=api-key=<your key> \
--from-literal=secret-key=<your key> 

kubectl apply -f rbac.yaml -n cert-manager

reflector to share certs between mamespaces

$ helm repo add emberstack https://emberstack.github.io/helm-charts
$ helm repo update
$ helm upgrade --install reflector emberstack/reflector


Add these annotations to certificate to share them between namespaces:
      # Permit for miror creation in the following namespace.
reflector.v1.k8s.emberstack.com/reflection-allowed: "true"
      # Automatically create a miror in the following namespace.
reflector.v1.k8s.emberstack.com/reflection-auto-enabled: "true"