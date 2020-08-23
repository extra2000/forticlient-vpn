# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vagrant.plugins = ["vagrant-reload", "vagrant-scp"]
end

forticlient_centos7_vagrantfile = './vagrant/Vagrantfile.forticlient-centos7'
load forticlient_centos7_vagrantfile if File.exists?(forticlient_centos7_vagrantfile)
