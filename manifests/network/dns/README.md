# Pi-hole installation 

This is an additional VM in proxmox running debian like the others.

the installation is straightforward as hell.

## install stuff
apt-get install curl openssh-server 


## modify /etc/network/interfaces to set the server's static IP: 

iface ens18 inet static
    address 192.168.0.53
    netmask 255.255.255.0
    gateway 192.168.0.1
    dns-domain vmnet.lan
    dns-nameservers localhost 8.8.8.8

## Installation
https://docs.pi-hole.net/main/basic-install/

curl -sSL https://install.pi-hole.net | bash

then follow the steps shown in screen



seems like there is no inherent way to create wildcard domains through the UI, so you can do the following:
1. Login to your pi-hole and go to /etc/dnsmasq.d/
2. Create a new file, lets call it 02-my-wildcard-dns.conf
3. Edit the file, and add a line like this:
address=/vmnet.lan/192.168.0.50
4. Save the file, and exit the editor
5. Run the command: service pihole-FTL restart

This will make the *.vmnet.lan a wildcard for traffic to be sent to the internal nginx ingress. 

-------

V2.
will create an adguard server to see klk



apiVersion: apps/v1
kind: Deployment
metadata:
  name: adguardhome
  namespace: dns
spec:
  replicas: 1
  selector:
    matchLabels:
      app: adguardhome
  template:
    metadata:
      labels:
        app: adguardhome
    spec:
      containers:
      - name: adguardhome
        image: adguard/adguardhome:latest
        volumeMounts:
          - name: workdir
            mountPath: /opt/adguardhome/work
          - name: confdir
            mountPath: /opt/adguardhome/conf
        restartPolicy: Always
      volumes:
        - name: workdir
          hostPath:
            path: "/var/nfs/vmnet/svc/dns/adguard/workdir"
        - name: confdir
          hostPath:
            path: "/var/nfs/vmnet/svc/dns/adguard/config"

---
apiVersion: v1
kind: Service
metadata:
  name: adguardhome
  namespace: dns
spec:
  selector:
    app: adguardhome
  ports:
    - port: 53
      targetPort: 53
      protocol: TCP
    - port: 53
      targetPort: 53
      protocol: UDP
    - port: 67
      targetPort: 67
      protocol: UDP
    - port: 68
      targetPort: 68
      protocol: UDP
    - port: 80
      targetPort: 80
      protocol: TCP
    - port: 443
      targetPort: 443
      protocol: TCP
    - port: 443
      targetPort: 443
      protocol: UDP
    - port: 3000
      targetPort: 3000
      protocol: TCP
    - port: 853
      targetPort: 853
      protocol: TCP
    - port: 784
      targetPort: 784
      protocol: UDP
    - port: 853
      targetPort: 853
      protocol: UDP
    - port: 8853
      targetPort: 8853
      protocol: UDP
    - port: 5443
      targetPort: 5443
      protocol: TCP
    - port: 5443
      targetPort: 5443
      protocol: UDP
  type: LoadBalancer


---
apiVersion: v1
kind: Service
metadata:
name: adguardhome
namespace: dns
spec:
selector:
app: adguardhome
ports:
- port: 53
targetPort: 53
protocol: TCP
- port: 53
targetPort: 53
protocol: UDP
- port: 67
targetPort: 67
protocol: UDP
- port: 68
targetPort: 68
protocol: UDP
- port: 80
targetPort: 80
protocol: TCP
- port: 443
targetPort: 443
protocol: TCP
- port: 443
targetPort: 443
protocol: UDP
- port: 3000
targetPort: 3000
protocol: TCP
- port: 853
targetPort: 853
protocol: TCP
- port: 784
targetPort: 784
protocol: UDP
- port: 853
targetPort: 853
protocol: UDP
- port: 8853
targetPort: 8853
protocol: UDP
- port: 5443
targetPort: 5443
protocol: TCP
- port: 5443
targetPort: 5443
protocol: UDP
type: LoadBalancer
