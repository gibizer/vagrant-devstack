# -*- mode: ruby -*-
# vi: set ft=ruby :


VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.hostmanager.enabled = true

  config.vm.provider :libvirt do |libvirt|
    libvirt.memory = 8192
    libvirt.nested = true
    libvirt.cpu_mode = "host-passthrough"
    libvirt.machine_virtual_size = 30
    libvirt.default_prefix = "devstack"
  end

  config.vm.box = "generic/ubuntu1804"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  hostnames = ['aio']
  hostnames.each do |name|
  config.vm.define "#{name}" do |system|
    system.vm.host_name = "#{name}"
    system.vm.provision "ansible" do |ansible|
        ansible.playbook = "#{name}.yml"
        ansible.inventory_path = "inventories/vagrant"
        ansible.limit = "all" # run ansible in parallel for all machines
        ansible.verbose = "vv"
      end
    end
  end

  config.vm.define :aio do |aio|
    aio.vm.network :private_network,
                   :libvirt__network_name => 'mgmt',
                   :libvirt__dhcp_enabled => false,
                   :ip => "192.168.111.3"
  end

end

