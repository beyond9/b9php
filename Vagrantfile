# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.hostname = "172.17.8.120"

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "b9centos"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "https://github.com/beyond9/b9centos/releases/download/v7.0.0/centos7-20141106.box"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :private_network, ip: "172.17.8.120"

  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.json.merge!({
      :php => {
        :timezone => "America/Chicago",
      }
    })
    chef.add_recipe "b9php::default"
    chef.add_recipe "b9php::pear"
    chef.add_recipe "b9php::oracle"
  end
end
