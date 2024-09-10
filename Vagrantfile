# -*- mode: ruby -*-
# vi: set ft=ruby :


VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

#   config.hostmanager.enabled = true

  config.vm.provider :libvirt do |libvirt|
    libvirt.cpus = 4
    libvirt.memory = 12288
    libvirt.nested = true
    libvirt.cpu_mode = "host-passthrough"
    libvirt.machine_virtual_size = 30
    libvirt.default_prefix = "devstack"
    libvirt.machine_type = "q35"
  end

  config.vm.box = "cloud-image/ubuntu-24.04"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  hostnames = ['aio']
  hostnames.each do |name|
  config.vm.define "#{name}" do |system|
    system.vm.host_name = "#{name}"
    system.vm.provision "ansible" do |ansible|
        ansible.playbook = "#{name}.yml"
        ansible.limit = "all" # run ansible in parallel for all machines
        ansible.verbose = "vv"
      end
    end
  end


end

