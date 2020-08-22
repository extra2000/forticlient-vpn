# forticlient-vpn

Automate FortiClient VPN client deployment. Unfortunately, forwarding VPN connections to host is not reliable at the moment. Need to deploy on the gateway device.


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


### Deploy using Podman in Vagrant

Build the FortiClient VPN client image:
```
$ vagrant ssh forticlient-box -- sudo salt-call state.sls forticlient.podman.present
```

To deploy:
```
$ vagrant ssh forticlient-box
$ sudo podman run --privileged -it -d --rm --name forticlient-vpn-client localhost/extra2000/forticlient-vpn-client
```
