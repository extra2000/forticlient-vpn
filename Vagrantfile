# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vagrant.plugins = ["vagrant-reload", "vagrant-scp"]
end

forticlient_box_vagrantfile = './vagrant/Vagrantfile.forticlient-box'
load forticlient_box_vagrantfile if File.exists?(forticlient_box_vagrantfile)
