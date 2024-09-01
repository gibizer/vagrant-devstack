openstack flavor create pci-nic-2 \
--vcpus 1 \
--ram 512 \
--disk 1 \
--property "pci_passthrough:alias"="nic:2" \
##