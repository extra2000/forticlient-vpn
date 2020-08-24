# forticlient-vpn

| License | Versioning | Build |
| ------- | ---------- | ----- |
| [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) | [![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release) | [![Build Status](https://travis-ci.com/extra2000/forticlient-vpn.svg?branch=master)](https://travis-ci.com/extra2000/forticlient-vpn) [![Build status](https://ci.appveyor.com/api/projects/status/3obkeq7px7782ov4/branch/master?svg=true)](https://ci.appveyor.com/project/nikAizuddin/forticlient-vpn/branch/master) |

Automate FortiClient VPN client deployment. Unfortunately, forwarding VPN connections to host is not reliable at the moment. Need to deploy on the gateway device.


## Prerequisites

Install Vagrant and virtual machine such as Libvirt or VirtualBox.


## Getting started

Clone this repository and `cd`:
```
$ git clone git@github.com:extra2000/forticlient-vpn.git
$ cd forticlient-vpn
```


## Preparations for localhost deployment using Vagrant

Copy your `.p12` certificate file into `salt/roots/formulas/forticlient-vpn-formula/forticlient-vpn/files/secrets/`.

Create `salt/roots/pillar/forticlient.sls` file as shown below. You may need to modify your credentials:
```
forticlient-vpn:
  credential:
    server: 172.1.1.1
    certificate: mycert.p12
    certpasswd: abcde12345
```


## Localhost deployment using Vagrant

Create `forticlient-ubuntu1804` Vagrant box and then SSH into the box. You may change `libvirt` to other provider such as `virtualbox` or `hyperv`:
```
$ vagrant up --provider=libvirt forticlient-ubuntu1804
$ vagrant ssh forticlient-ubuntu1804
```

Install FortiClient VPN client and deploy using the following commands:
```
$ sudo salt-call state.sls forticlient-vpn
```

To uninstall FortiClient VPN client and clean files:
```
$ sudo salt-call state.sls forticlient-vpn.clean
```
