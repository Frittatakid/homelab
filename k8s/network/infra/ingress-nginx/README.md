You can provision the nginx ingress controller and its components through the following command
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

Despite of this, a slightly modified version of it is the ingress-nginx.yaml, which forces a specific IP on this service (192.168.0.50)


in the nextcloud ingress annotation, take note of:
nginx.ingress.kubernetes.io/proxy-body-size: "10G"
The size can be adjusted, the reason for this is that uploads from the nextcloud app fail when going through the ingress for some reason. This annotation fixes that.

