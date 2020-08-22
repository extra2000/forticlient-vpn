# forticlient-vpn

Automate FortiClient VPN deployment


## Prerequisites

Install Vagrant and virtual machine such as Libvirt or VirtualBox.


## Getting started

Clone this repository and `cd`:
```
$ git clone git@github.com:extra2000/forticlient-vpn.git
$ cd forticlient-vpn
```


## Preparations for localhost deployment using Vagrant?

Copy your `.p12` certificate file into `salt/roots/salt/forticlient/secrets/`.

Create `salt/roots/pillar/credential.sls` file and set your credentials, for example:
```
credential:
  server: 172.1.1.1
  certificate: mycert.p12
  certpasswd: abcde12345
```

Create `forticlient-box` Vagrant box and bootstrap it. You may change `libvirt` to other provider such as `virtualbox` or `hyperv`:
```
$ vagrant up --provider=libvirt
$ vagrant ssh forticlient-box -- sudo salt-call state.highstate saltenv=base
$ vagrant reload
```


### Deploy without Podman in Vagrant

Install FortiClient VPN client and deploy using the following commands:
```
$ vagrant ssh forticlient-box -- sudo salt-call state.sls forticlient.host.present
$ vagrant ssh forticlient-box -- sudo salt-call state.sls forticlient.host.deploy
```

Execute on `forticlient-box`:
```
$ for iface in $(ip a | grep eth | grep inet | awk '{print $2}'); do sudo iptables -t nat -A POSTROUTING -s "$iface" -j MASQUERADE; done
$ sudo iptables -t nat -A POSTROUTING -s 192.168.121.214 -j MASQUERADE
```

Supposed you want to connect with server `172.168.1.2` from host, execute the following command and then test with `ssh-keyscan`:
```
$ sudo ip route add 172.168.0.0/16 via `sudo virsh net-dhcp-leases vagrant-libvirt | grep forticlient-box | awk '{print $5}' | gawk 'match($0, /(.*)\//, a) {print a[1]}'`
$ ssh-keyscan -t rsa 172.168.1.2
```


### Deploy using Podman in Vagrant

Supposed you want to connect with server `172.168.1.2` from `forticlient-box` guest (which is the host to the container), execute the following command and test with `ssh-keyscan`:
```
$ vagrant ssh forticlient-box -- sudo salt-call state.sls forticlient.podman.present
$ vagrant ssh forticlient-box
$ sudo podman run --privileged -it -d --rm --name forticlient-vpn-client localhost/extra2000/forticlient-vpn-client
$ sudo ip route add default via `sudo podman inspect forticlient-vpn-client | grep IPAddress | awk '{print $2}' | gawk 'match($0, /\"(.*)\"/, a) {print a[1]}'`
$ sudo ip route add 172.168.0.0/16 via `sudo podman inspect forticlient-vpn-client | grep IPAddress | awk '{print $2}' | gawk 'match($0, /\"(.*)\"/, a) {print a[1]}'`
$ ssh-keyscan -t rsa 172.168.1.2
```
