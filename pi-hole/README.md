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
    dns-domain vmnet.io
    dns-nameservers localhost 8.8.8.8

## Installation
https://docs.pi-hole.net/main/basic-install/

curl -sSL https://install.pi-hole.net | bash

then follow the steps shown in screen