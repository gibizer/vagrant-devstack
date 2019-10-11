openstack network create net0 \
--provider-network-type vlan \
--provider-physical-network physnet0 \
--provider-segment 100 \
##
openstack subnet create subnet0 \
--network net0 \
--subnet-range 10.0.4.0/24 \
##
openstack network qos policy create qp0
openstack network qos rule create qp0 \
--type minimum-bandwidth \
--min-kbps 1000 \
--egress \
##
openstack network qos rule create qp0 \
--type minimum-bandwidth \
--min-kbps 1000 \
--ingress \
##
openstack port create port-normal \
--network net0 \
--vnic-type normal \
##
openstack port create port-normal-qos \
--network net0 \
--vnic-type normal \
--qos-policy qp0 \
##
openstack port create port-direct \
--network net0 \
--vnic-type direct \
##
openstack port create port-direct-qos \
--network net0 \
--vnic-type direct \
--qos-policy qp0 \
##
