kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

The file in this directory has a modified parameter in the args for "--kubelet-insecure-tls", without this the metrics
server will not work unless additional security thingies are done on a cluster level.
