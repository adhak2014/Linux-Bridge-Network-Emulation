echo "\n"
echo "Brief display of ip links"
ip -br -c link
echo "\n"
echo "Create bridge br0"
brctl addbr br0
echo "\n"
echo "Enable bridge br0"
ip link set dev br0 up
echo "\n"
echo "Brief display of ip links"
ip -br -c link
echo "\n"
echo "Create virtual Ethernet cable between h1 namespace and bridge br0"
ip link add name h1-eth0 type veth peer br0-eth1
echo "\n"
echo "Create virtual Ethernet cable between h2 namespace and bridge br0"
ip link add name h2-eth0 type veth peer br0-eth2
echo "\n"
echo "Create virtual Ethernet cable between h3 namespace and bridge br0"
ip link add name h3-eth0 type veth peer br0-eth3
echo "\n"
echo "Create virtual Ethernet cable between h4 namespace and bridge br0"
ip link add name h4-eth0 type veth peer br0-eth4
echo "\n"
echo "Brief display of ip links"
ip -br -c link
echo "\n"
echo "Create h1 namespace"
ip netns add h1
echo "\n"
echo "Create h2 namespace"
ip netns add h2
echo "\n"
echo "Create h3 namespace"
ip netns add h3
echo "\n"
echo "Create h4 namespace"
ip netns add h4
echo "\n"
echo "Link virtual interface h1-eth0 to h1 namespace"
ip link set dev h1-eth0 netns h1
echo "\n"
echo "Bring virtual interface h1-eth0 up"
ip -n h1 link set dev h1-eth0 up
echo "\n"
echo "Assign 192.168.0.1/24 to virtual interface h1-eth0"
ip -n h1 address add 192.168.0.1/24 dev h1-eth0
echo "\n"
echo "Link virtual interface h2-eth0 to h2 namespace"
ip link set dev h2-eth0 netns h2
echo "\n"
echo "Bring virtual interface h2-eth0 up"
ip -n h2 link set dev h2-eth0 up
echo "\n"
echo "Assign 192.168.0.2/24 to virtual interface h2-eth0"
ip -n h2 address add 192.168.0.2/24 dev h2-eth0
echo "\n"
echo "Link virtual interface h3-eth0 to h3 namespace"
ip link set dev h3-eth0 netns h3
echo "\n"
echo "Bring virtual interface h3-eth0 up"
ip -n h3 link set dev h3-eth0 up
echo "\n"
echo "Assign 192.168.0.3/24 to virtual interface h3-eth0"
ip -n h3 address add 192.168.0.3/24 dev h3-eth0
echo "\n"
echo "Link virtual interface h4-eth0 to h4 namespace"
ip link set dev h4-eth0 netns h4
echo "\n"
echo "Bring virtual interface h4-eth0 up"
ip -n h4 link set dev h4-eth0 up
echo "\n"
echo "Assign 192.168.0.4/24 to virtual interface h4-eth0"
ip -n h4 address add 192.168.0.4/24 dev h4-eth0
echo "\n"
echo "Display all namespaces"
ip netns
echo "\n"
echo "Brief display of h1 namespace address"
ip -c -br -n h1 address show
echo "\n"
echo "Brief display of h2 namespace address"
ip -c -br -n h2 address show
echo "\n"
echo "Brief display of h3 namespace address"
ip -c -br -n h3 address show
echo "\n"
echo "Brief display of h4 namespace address"
ip -c -br -n h4 address show
echo "\n"
echo "Brief display of ip links"
ip -br -c link
echo "\n"
echo "Bring virtual port br0-eth1 up"
ip link set dev br0-eth1 up
echo "\n"
echo "Bring virtual port br0-eth2 up"
ip link set dev br0-eth2 up
echo "\n"
echo "Bring virtual port br0-eth3 up"
ip link set dev br0-eth3 up
echo "\n"
echo "Bring virtual port br0-eth4 up"
ip link set dev br0-eth4 up
echo "\n"
echo "Brief display of ip links"
ip -br -c link
echo "\n"
echo "Display bridge br0 links"
bridge link show br0
echo "\n"
echo "Link virtual port br0-eth1 to bridge br0"
ip link set dev br0-eth1 master br0
echo "\n"
echo "Link virtual port br0-eth2 to bridge br0"
ip link set dev br0-eth2 master br0
echo "\n"
echo "Link virtual port br0-eth3 to bridge br0"
ip link set dev br0-eth3 master br0
echo "\n"
echo "Link virtual port br0-eth4 to bridge br0"
ip link set dev br0-eth4 master br0
echo "\n"
echo "Brief display of ip links"
ip -br -c link
echo "\n"
echo "Display bridge br0 links"
bridge link show br0
echo "\n"
echo "Display Linux bridge"
brctl show
echo "\n"
echo "Display bridge links"
bridge link
echo "\n"
echo "From h1, test IP reachability with h2"
ip netns exec h1 ping -c2 192.168.0.2
echo "\n"
echo "From h1, test IP reachability with h3"
ip netns exec h1 ping -c2 192.168.0.3
echo "\n"
echo "From h1, test IP reachability with h4"
ip netns exec h1 ping -c2 192.168.0.4
echo "\n"
echo "Check bridge br0 vlan filtering"
ip -j -d -p link show br0
echo "\n"
echo "Enable vlan filtering"
ip link se dev br0 type bridge vlan_filtering 1
echo "\n"
echo "Check bridge br0 vlan filtering"
ip -j -d -p link show br0
echo "\n"
echo "Show existing vlans"
bridge vlan show
echo "\n"
echo "Assign virtual port br0 to VLAN 99"
bridge vlan add vid 99 dev br0 pvid untagged self
echo "\n"
echo "Assign virtual port br0-eth1 to VLAN 10"
bridge vlan add vid 10 dev br0-eth1 pvid untagged master
echo "\n"
echo "Assign virtual port br0-eth2 to VLAN 10"
bridge vlan add vid 10 dev br0-eth2 pvid untagged master
echo "\n"
echo "Assign virtual port br0-eth3 to VLAN 20"
bridge vlan add vid 20 dev br0-eth3 pvid untagged master
echo "\n"
echo "Assign virtual port br0-eth4 to VLAN 20"
bridge vlan add vid 20 dev br0-eth4 pvid untagged master
echo "\n"
echo "Show existing vlans"
bridge vlan show
echo "\n"
echo "Delete vlan 1 from virtual port br0"
bridge vlan del vid 1 dev br0 self
echo "\n"
echo "Delete vlan 1 from virtual port br0-eth1"
bridge vlan del vid 1 dev br0-eth1
echo "\n"
echo "Delete vlan 1 from virtual port br0-eth2"
bridge vlan del vid 1 dev br0-eth2
echo "\n"
echo "Delete vlan 1 from virtual port br0-eth3"
bridge vlan del vid 1 dev br0-eth3
echo "\n"
echo "Delete vlan 1 from virtual port br0-eth4"
bridge vlan del vid 1 dev br0-eth4
echo "\n"
echo "Show existing vlans"
bridge vlan show
echo "\n"
echo "From h1, test IP reachability with h2"
ip netns exec h1 ping -c2 192.168.0.2
echo "\n"
echo "From h1, test IP reachability with h3"
ip netns exec h1 ping -c2 192.168.0.3
echo "\n"
echo "From h3, test IP reachability with h4"
ip netns exec h3 ping -c2 192.168.0.4
echo "\n"
echo "From h3, test IP reachability with h2"
ip netns exec h3 ping -c2 192.168.0.2
echo "\n"
echo "Display forwarding database of bridge br0"
bridge fdb show br0
echo "\n"
echo "Display dynamic forwarding database of bridge br0"
bridge fdb show dynamic br0
echo "\n"
echo "Bring virtual bridge port br0-eth1 down"
ip link set br0-eth1 down
echo "\n"
echo "Remove virtual port br0-eth1 from bridge br0"
ip link set br0-eth1 nomaster
echo "\n"
echo "Bring virtual bridge port br0-eth2 down"
ip link set br0-eth2 down
echo "\n"
echo "Remove virtual port br0-eth2 from bridge br0"
ip link set br0-eth2 nomaster
echo "\n"
echo "Bring virtual bridge port br0-eth3 down"
ip link set br0-eth3 down
echo "\n"
echo "Remove virtual port br0-eth3 from bridge br0"
ip link set br0-eth3 nomaster
echo "\n"
echo "Bring virtual bridge port br0-eth4 down"
ip link set br0-eth4 down
echo "\n"
echo "Remove virtual port br0-eth4 from bridge br0"
ip link set br0-eth4 nomaster
echo "\n"
echo "Bring bridge br0 down"
ip link set br0 down
echo "\n"
echo "Delete bridge br0"
ip link delete br0 type bridge
echo "\n"
echo "Bring h1 namespace interface h1-eth0 down"
ip netns exec h1 ip link set dev h1-eth0 down
echo "\n"
echo "Bring h2 namespace interface h2-eth0 down"
ip netns exec h2 ip link set dev h2-eth0 down
echo "\n"
echo "Bring h3 namespace interface h3-eth0 down"
ip netns exec h3 ip link set dev h3-eth0 down
echo "\n"
echo "Bring h4 namespace interface h4-eth0 down"
ip netns exec h4 ip link set dev h4-eth0 down
echo "\n"
echo "Delete h1 namespace"
ip netns delete h1
echo "\n"
echo "Delete h2 namespace"
ip netns delete h2
echo "\n"
echo "Delete h3 namespace"
ip netns delete h3
echo "\n"
echo "Delete h4 namespace"
ip netns delete h4
echo "\n"
echo "Check if any namespace(s) is/are left"
ip netns
echo "\n"

sleep 2

echo "Check ip links"
ip link
