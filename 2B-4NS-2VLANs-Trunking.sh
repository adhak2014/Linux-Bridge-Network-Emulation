echo ""
echo "Brief display of ip links"
ip -br -c link
echo ""
echo "Create virtual Ethernet cable h1-eth0 <---------------> br0-eth1"
ip link add name h1-eth0 type veth peer br0-eth1
echo ""
echo "Create virtual Ethernet cable h2-eth0 <---------------> br0-eth2"
ip link add name h2-eth0 type veth peer br0-eth2
echo ""
echo "Create virtual Ethernet cable h3-eth0 <---------------> br1-eth1"
ip link add name h3-eth0 type veth peer br1-eth1
echo ""
echo "Create virtual Ethernet cable h4-eth0 <---------------> br1-eth2"
ip link add name h4-eth0 type veth peer br1-eth2
echo ""
echo "Create virtual Ethernet cable br0-eth3 <---------------> br1-eth3"
ip link add name br0-eth3 type veth peer br1-eth3
echo ""
echo "Create bridge br0"
ip link add name br0 type bridge
echo ""
echo "Create bridge br1"
ip link add name br1 type bridge
echo ""
echo "Enable bridge br0"
ip link set dev br0 up
echo ""
echo "Enable bridge br1"
ip link set dev br1 up
echo ""
echo "Link virtual port br0-eth1 to bridge br0"
ip link set dev br0-eth1 master br0
echo ""
echo "Link virtual port br0-eth2 to bridge br0"
ip link set dev br0-eth2 master br0
echo ""
echo "Link virtual port br0-eth3 to bridge br0"
ip link set dev br0-eth3 master br0
echo ""
echo "Link virtual port br1-eth1 to bridge br1"
ip link set dev br1-eth1 master br1
echo ""
echo "Link virtual port br1-eth2 to bridge br1"
ip link set dev br1-eth2 master br1
echo ""
echo "Link virtual port br1-eth3 to bridge br1"
ip link set dev br1-eth3 master br1
echo ""
echo "Bring virtual port br0-eth1 up"
ip link set dev br0-eth1 up
echo ""
echo "Bring virtual port br0-eth2 up"
ip link set dev br0-eth2 up
echo ""
echo "Bring virtual port br0-eth3 up"
ip link set dev br0-eth3 up
echo ""
echo "Bring virtual port br1-eth1 up"
ip link set dev br1-eth1 up
echo ""
echo "Bring virtual port br1-eth2 up"
ip link set dev br1-eth2 up
echo ""
echo "Bring virtual port br1-eth3 up"
ip link set dev br1-eth3 up
echo ""
echo "Create h1 namespace"
ip netns add h1
echo ""
echo "Create h2 namespace"
ip netns add h2
echo ""
echo "Create h3 namespace"
ip netns add h3
echo ""
echo "Create h4 namespace"
ip netns add h4
echo ""
echo "Display all namespaces"
ip netns
echo ""
echo "Link virtual interface h1-eth0 to h1 namespace"
ip link set dev h1-eth0 netns h1
echo ""
echo "Link virtual interface h2-eth0 to h2 namespace"
ip link set dev h2-eth0 netns h2
echo ""
echo "Link virtual interface h3-eth0 to h3 namespace"
ip link set dev h3-eth0 netns h3
echo ""
echo "Link virtual interface h4-eth0 to h4 namespace"
ip link set dev h4-eth0 netns h4
echo ""
echo "Assign 192.168.1.1/24 to virtual interface h1-eth0"
ip -n h1 address add 192.168.1.1/24 dev h1-eth0
echo ""
echo "Assign 192.168.2.1/24 to virtual interface h2-eth0"
ip -n h2 address add 192.168.2.1/24 dev h2-eth0
echo ""
echo "Assign 192.168.1.2/24 to virtual interface h3-eth0"
ip -n h3 address add 192.168.1.2/24 dev h3-eth0
echo ""
echo "Assign 192.168.2.2/24 to virtual interface h4-eth0"
ip -n h4 address add 192.168.2.2/24 dev h4-eth0
echo ""
echo "Bring virtual interface h1-eth0 up"
ip -n h1 link set dev h1-eth0 up
echo ""
echo "Bring virtual interface h2-eth0 up"
ip -n h2 link set dev h2-eth0 up
echo ""
echo "Bring virtual interface h3-eth0 up"
ip -n h3 link set dev h3-eth0 up
echo ""
echo "Bring virtual interface h4-eth0 up"
ip -n h4 link set dev h4-eth0 up
echo ""
echo "Brief display of h1 namespace address"
ip -c -br -n h1 address show
echo ""
echo "Brief display of h2 namespace address"
ip -c -br -n h2 address show
echo ""
echo "Brief display of h3 namespace address"
ip -c -br -n h3 address show
echo ""
echo "Brief display of h4 namespace address"
ip -c -br -n h4 address show
echo ""
echo "Display bridge br0 links"
bridge link show br0
echo ""
echo "Display bridge br1 links"
bridge link show br1
echo ""
echo "Brief display of ip links"
ip -br -c link show
echo ""
echo "Enable vlan filtering in bridge br0"
ip link set dev br0 type bridge vlan_filtering 1 vlan_default_pvid 0
echo ""
echo "Enable vlan filtering in bridge br1"
ip link set dev br1 type bridge vlan_filtering 1 vlan_default_pvid 0
echo ""
echo "Show existing vlans"
bridge vlan show
echo ""
echo "Assign virtual port br0-eth1 to VLAN 10"
bridge vlan add vid 10 dev br0-eth1 pvid untagged
echo ""
echo "Assign virtual port br0-eth2 to VLAN 20"
bridge vlan add vid 20 dev br0-eth2 pvid untagged
echo ""
echo "Configure virtual port br0-eth3 as a VLAN trunk"
bridge vlan add vid 10 dev br0-eth3
bridge vlan add vid 20 dev br0-eth3
echo ""
echo "Assign virtual port br1-eth1 to VLAN 10"
bridge vlan add vid 10 dev br1-eth1 pvid untagged
echo ""
echo "Assign virtual port br1-eth2 to VLAN 20"
bridge vlan add vid 20 dev br1-eth2 pvid untagged
echo ""
echo "Configure virtual port br1-eth3 as a VLAN trunk"
bridge vlan add vid 10-20 dev br1-eth3
echo ""
echo "Delete vlan 1 from virtual port br0-eth1"
bridge vlan del vid 1 dev br0-eth1
echo ""
echo "Delete vlan 1 from virtual port br0-eth2"
bridge vlan del vid 1 dev br0-eth2
echo ""
echo "Delete vlan 1 from virtual port br1-eth1"
bridge vlan del vid 1 dev br1-eth1
echo ""
echo "Delete vlan 1 from virtual port br1-eth2"
bridge vlan del vid 1 dev br1-eth2
echo ""
echo "Show current vlans with compressvlans switch (-c) in port br0-eth1"
bridge -c vlan show dev br0-eth1
echo ""
echo "Show current vlans with compressvlans switch (-c) in port br0-eth3"
bridge -c vlan show dev br0-eth3
echo ""
echo "Enable vlan statistics on bridge br0"
ip link set br0 type bridge vlan_stats_enable 1
echo ""
echo "Enable vlan statistics on bridge br1"
ip link set br1 type bridge vlan_stats_enable 1
echo ""

#echo "Enable per port vlan statistics on bridge br0"
#ip link set br0 type bridge vlan_stats_per_port 1
#echo ""
#echo "Enable per port vlan statistics on bridge br1"
#ip link set br1 type bridge vlan_stats_per_port 1
#echo ""

echo "From h1, test IP reachability with h3"
ip netns exec h1 ping -c4 192.168.1.2 | grep transmitted
echo ""
echo "From h2, test IP reachability with h4"
ip netns exec h2 ping -c4 192.168.2.2 | grep transmitted
echo ""
echo "Show current vlans with compressvlans switch (-c)"
bridge -c vlan show
echo ""
echo "Show current vlans with compressvlans switch (-c) in port br1-eth3"
bridge -c vlan show dev br1-eth3
echo ""
echo "Brief display of ip links"
ip -br -c link
echo ""
echo "Display vlan statistics on bridges"
bridge -s vlan show
echo ""
echo "Display h1 namespace ip routing table"
ip -n h1 route
echo ""
echo "Display h2 namespace ip routing table"
ip -n h2 route
echo ""
echo "Display h3 namespace ip routing table"
ip -n h3 route
echo ""
echo "Display h4 namespace ip routing table"
ip -n h4 route
echo ""
echo "Bring virtual bridge port br0-eth1 down"
ip link set br0-eth1 down
echo ""
echo "Remove virtual port br0-eth1 from bridge br0"
ip link set br0-eth1 nomaster
echo ""
echo "Bring virtual bridge port br0-eth2 down"
ip link set br0-eth2 down
echo ""
echo "Remove virtual port br0-eth2 from bridge br0"
ip link set br0-eth2 nomaster
echo ""
echo "Bring virtual bridge port br1-eth1 down"
ip link set br1-eth1 down
echo ""
echo "Remove virtual port br1-eth1 from bridge br1"
ip link set br1-eth1 nomaster
echo ""
echo "Bring virtual bridge port br1-eth2 down"
ip link set br1-eth2 down
echo ""
echo "Remove virtual port br1-eth2 from bridge br1"
ip link set br1-eth2 nomaster
echo ""
echo "Delete virtual Ethernet cable br0-eth3 <---------------> br1-eth3"
ip link del name br0-eth3 type veth peer br1-eth3
echo ""
echo "Bring bridge br0 down"
ip link set br0 down
echo ""
echo "Delete bridge br0"
ip link delete br0 type bridge
echo ""
echo "Bring bridge br1 down"
ip link set br1 down
echo ""
echo "Delete bridge br1"
ip link delete br1 type bridge
echo ""
echo "Bring h1 namespace interface h1-eth0 down"
ip netns exec h1 ip link set dev h1-eth0 down
echo ""
echo "Bring h2 namespace interface h2-eth0 down"
ip netns exec h2 ip link set dev h2-eth0 down
echo ""
echo "Bring h3 namespace interface h3-eth0 down"
ip netns exec h3 ip link set dev h3-eth0 down
echo ""
echo "Bring h4 namespace interface h4-eth0 down"
ip netns exec h4 ip link set dev h4-eth0 down
echo ""
echo "Delete h1 namespace"
ip netns delete h1
echo ""
echo "Delete h2 namespace"
ip netns delete h2
echo ""
echo "Delete h3 namespace"
ip netns delete h3
echo ""
echo "Delete h4 namespace"
ip netns delete h4
echo ""
echo "Check if any namespace(s) is/are left"
ip netns
echo ""

sleep 2

echo "Check ip links"
ip link
echo ""
