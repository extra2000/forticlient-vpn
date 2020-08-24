# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vagrant.plugins = ["vagrant-reload", "vagrant-scp"]
end

forticlient_centos7_vagrantfile = './vagrant/Vagrantfile.forticlient-centos7'
load forticlient_centos7_vagrantfile if File.exists?(forticlient_centos7_vagrantfile)

forticlient_ubuntu1804_vagrantfile = './vagrant/Vagrantfile.forticlient-ubuntu1804'
load forticlient_ubuntu1804_vagrantfile if File.exists?(forticlient_ubuntu1804_vagrantfile)
