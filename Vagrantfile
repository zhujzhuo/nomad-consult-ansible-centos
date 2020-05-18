# -*- mode: ruby -*-
# vi: set ft=ruby :
# For vagrant version of this repo, you will have to edit all references to eth0 in ansible recipes, and replace by eth1 (as eth1 is the common network between all nodes).

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "centos/7"
  #config.vm.synced_folder ".", "/vagrant", type: "virtualbox", owner: "vagrant", mount_options: ["dmode=775,fmode=600"]
  config.vm.synced_folder ".", "/vagrant", type: "nfs"
  
  provisioner = Vagrant::Util::Platform.windows? ? :guest_ansible : :ansible

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.cpus = 1
  end


  config.vm.define "node2" do |node2|
    node2.vm.hostname = "node2"
    node2.vm.network "private_network", ip: "172.28.128.11"
    node2.vm.provision "shell", path: "install.sh"
  end

  config.vm.define "node3" do |node3|
    node3.vm.hostname = "node3"
    node3.vm.network "private_network", ip: "172.28.128.12"  
    node3.vm.provision "shell", path: "install.sh"
  end
  config.vm.define "node4" do |node4|
    node4.vm.hostname = "node4"
    node4.vm.network "private_network", ip: "172.28.128.13"  
    node4.vm.provision "shell", path: "install.sh"
  end
  config.vm.define "node5" do |node5|
    node5.vm.hostname = "node5"
    node5.vm.network "private_network", ip: "172.28.128.14"  
    node5.vm.provision "shell", path: "install.sh"
  end
      
  
  config.vm.define "node1" do |node1| 
    node1.vm.hostname = "node1"
    node1.vm.network "private_network", ip: "172.28.128.10"
    node1.vm.provision "shell", path: "install.sh"
    node1.vm.provision :ansible_local do |ansible|
      ansible.verbose = "v"
      ansible.install = true
      ansible.playbook = "playbook.yml"
      ansible.inventory_path = "inventory"
      ansible.limit = "all"
    end
  end

  # Fix new ip not showing after initialized
  config.vm.provision "shell", run: "always", inline: "sudo /sbin/ifup eth1"
  
  
  
end
