# homelab
My own homelab based off Proxmox and Kubernetes.

# Kubernetes Cluster Deployment within Proxmox VMs

The goal of this setup is to deploy a Kubernetes cluster within Proxmox VMs. Within the cluster, there will be a series of services: DNS server, DHCP server, a Jellyfin media streaming stack, and a network storage solution.

## Hardware Overview
- **Host Machine**: Lenovo ThinkCentre M720q
- **Storage and RAID Host**: Asustor NAS

## Proxmox VMs
- **Master Node**: One VM
- **Worker Node**: One VM
- **Pihole DNS server**: One VM

## Setup Steps

1. Set up Proxmox, Create VMs, Install Debian on Them
2. Install `kubectl`, `kubeadm`
3. Install the Kubernetes Cluster via `kubeadm`
4. Set up Networking Aspects

# 1. Set up Proxmox, Create VMs, Install Debian on Them

## Steps

1. **Install Proxmox.**
2. **Create VMs.**
3. **Install Debian on each VM.**
4. **Configure important aspects of the OS**

## Within Debian

1. Install essential packages:
   ```sh
   apt-get install sudo vim curl sudo openssh-server

   ```
2. Add your user as sudo
```sh
sudo adduser <user> sudo
```
3. Disable swap (this is really important, the kubelet will not work if you don't do it.)
```
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
```
4. Maybe set a static ip in /etc/network/interfaces
```
iface ens18 inet static
   address 192.168.0.x
   netmask 255.255.255.0
   gateway 192.168.0.1
   dns-domain vmnet.io
   dns-nameservers 8.8.8.8
```
5. set up /etc/fstab for automatic mount of nfs
   
echo "192.168.0.80:/volume1/nas    /var/nfs/    nfs    default    0  0" >> /etc/fstab

### Preparing for the cluster deployment

## Install kubeadm
  ```sh
  sudo apt-get install -y kubeadm
  ```

## Install kubectl

1. **Install kubectl**:
   ```sh
   sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2
   curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
   echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
   sudo apt-get update
   sudo apt-get install -y kubectl
   ```
## Install Docker on All Nodes

   - Follow the [Docker installation guide for Debian](https://docs.docker.com/engine/install/debian/).
   - Set up Docker for your user: [Post-installation steps for Docker](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).


## Initializing the cluster


### install_kubernetes.md

# 3. Install the Kubernetes Cluster via `kubeadm`

## Initialize the Kubernetes Master Node

1. **Initialize the Kubernetes master node**:
   ```sh
   sudo kubeadm init


#You may want to set up your kubeconfig in order to access the apiserver
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
After initializing your cluster, you will get a prompt on the master node in order for worker nodes to join the cluster.



# Setting Up Networking in the Kubernetes Cluster

## Install the nginx Ingress Controller

The nginx ingress controller manages incoming traffic and routes it to the appropriate services within the cluster.

1. **Install the nginx ingress controller**:
   - Follow the [nginx ingress controller installation guide](https://kubernetes.github.io/ingress-nginx/deploy/).
     kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.0-beta.0/deploy/static/provider/baremetal/deploy.yaml
2. **Set up a hostname**:
   - If you don't have a hostname, you can use cluster paths. Refer to the [nginx ingress controller guide](https://kubernetes.github.io/ingress-nginx/deploy/) for details on configuring hostnames and paths.

## Install calico
https://docs.tigera.io/calico/latest/getting-started/kubernetes/self-managed-onprem/onpremises

## Install MetalLB

MetalLB provides a network load balancer implementation for Kubernetes. It allows you to expose services externally with a set of IP addresses.

1. **Install MetalLB**:
   - Follow the [MetalLB installation guide](https://metallb.universe.tf/installation/).
   - Apply the manifest
     kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.8/config/manifests/metallb-native.yaml
2. **Configure IP pools**:
   - Create a generic auto-assign pool and a specific pool for the DNS server.
   - Also you may want a static address for your DNS server that we will install in the cluster and expose externally.
3. **Set up l2 advertisement**
   - In metallb there are two modes, BGP and l2. In this case, as we are just working with a single network, we use L2 mode.  







   we need nfs to mount the nas
   
apt install nfs-common

run this to add to fstab the mount so it mounts on restart
echo "192.168.0.222:/volume1/nas    /var/nfs/    nfs    default    0  0" >> /etc/fstab

you can run then this if you dont want to reboot
mount -a
systemctl daemon-reload




Install the metrics server to check on the server's metrics (kubectl top x for example)

kubectl apply -f .\manifests\metrics-server\components.yaml

this yaml is a modified version of the one in https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
adding the --kubelet-insecure-tls flag to the deployment, as it wont work otherwise.
