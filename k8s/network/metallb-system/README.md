metallb is in charge of providing the services with external IP addresses within the local network


k apply -f metallb.yaml
k apply -f l2advertisement.yaml
k apply -f ippool-default.yaml




