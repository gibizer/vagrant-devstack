# -*- mode: ruby -*-
# vi: set ft=ruby :


VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider :libvirt do |libvirt|
    libvirt.cpus = 4
    libvirt.memory = 12288
    libvirt.nested = true
    libvirt.cpu_mode = "host-passthrough"
    libvirt.machine_virtual_size = 30
    libvirt.default_prefix = "devstack-"
    libvirt.machine_type = "q35"
  end

  config.vm.box = "cloud-image/ubuntu-24.04"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  NR_OF_COMPUTES = 1
  (1..NR_OF_COMPUTES).each do |compute_id|

    config.vm.define "compute#{compute_id}" do |compute|
      compute.vm.host_name = "compute#{compute_id}"

      compute.vm.provider :libvirt do |domain|
        domain.memory = 4096
        domain.cpus = 2
      end
    end
  end

  config.vm.define "aio" do |aio|
    aio.vm.host_name = "aio"

    # HACK: Only run ansible once and after all the machines are up
    aio.vm.provision "ansible" do |ansible|
      ansible.compatibility_mode = "2.0"
      ansible.playbook = "devstack.yaml"
      ansible.limit = "all" # run ansible in parallel for all machines
      ansible.verbose = "vv"
      ansible.groups = {
        "aios" => ["aio"],
        "aios:vars" => {"devstack_local_conf" => "local.conf"},
        "computes" => ["compute[1:#{NR_OF_COMPUTES}]"],
        "computes:vars" => {"devstack_local_conf" => "compute_local.conf"},
      }
    end
  end

end

