AGENT_RP=`openstack --os-placement-api-version 1.28 resource provider list | grep 'aio:Open vSwitch agent ' | cut -d'|' -f2`

openstack \
	--os-placement-api-version 1.28 \
	resource class create CUSTOM_NET_KILOPACKET_PER_SEC

openstack resource provider inventory set \
	--resource CUSTOM_NET_KILOPACKET_PER_SEC:total=2000 \
	--amend \
	$AGENT_RP


openstack \
	--os-placement-api-version 1.29 \
	allocation candidate list \
	--resource VCPU=1 \
# port 1
	--group 1 \
	--resource NET_BW_EGR_KILOBIT_PER_SEC=10 \
	--resource NET_BW_IGR_KILOBIT_PER_SEC=10 \
# port 2
	--group 2 \
	--resource NET_BW_EGR_KILOBIT_PER_SEC=20 \
	--resource NET_BW_IGR_KILOBIT_PER_SEC=20 \
# port 2 also has packet rate request
# but it does not work, a named group can only be fulfilled
# from a single RP ?!
# with a separate group it works
#	--group 3 \
	--resource CUSTOM_NET_KILOPACKET_PER_SEC=45

