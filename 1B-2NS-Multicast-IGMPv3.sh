echo ""
echo "Create h1 namespace"
ip netns add h1
echo ""
echo "Create h2 namespace"
ip netns add h2
echo ""
echo "Display all namespaces"
ip netns
echo ""
echo "Display again all namespaces"
ls /var/run/netns
echo ""
echo "List interfaces on the host"
ip link
echo ""
echo "List interfaces on h1 namespace"
ip netns exec h1 ip link
echo ""
echo "List interfaces on h2 namespace"
ip netns exec h2 ip link
echo ""
echo "Create bridge br0"
brctl addbr br0
echo ""
echo "Enable bridge br0"
ip link set dev br0 up
echo ""
echo "Create virtual Ethernet cable h1-eth0 <---------------> br0-eth1"
ip link add h1-eth0 type veth peer name br0-eth1
echo ""
echo "Create virtual Ethernet cable h2-eth0 <---------------> br0-eth2"
ip link add h2-eth0 type veth peer name br0-eth2
echo ""
echo "Add virtual port br0-eth1 to bridge br0"
brctl addif br0 br0-eth1
echo ""
echo "Add virtual port br0-eth2 to bridge br0"
brctl addif br0 br0-eth2
echo ""
echo "Bring virtual bridge port br0-eth1 up"
ip link set br0-eth1 up
echo ""
echo "Bring virtual bridge port br0-eth2 up"
ip link set br0-eth2 up
echo ""
echo "Assign IP address to bridge br0"
ip addr add 192.168.1.1/24 dev br0
echo ""
echo "Display Linux bridge"
brctl show
echo ""
echo "Display bridge links"
bridge link
echo ""
echo "Attach virtual interface h1-eth0 to h1 namespace"
ip link set h1-eth0 netns h1
echo ""
echo "Bring virtual interface h1-eth0 in h1 namespace up"
ip -n h1 link set h1-eth0 up
echo ""
echo "Assign IP address 192.168.0.1 to h1-eth0 in h1 namespace"
ip -n h1 addr add 192.168.0.1/24 dev h1-eth0
echo ""
echo "Bring virtual interface lo in h1 namespace up"
ip netns exec h1 ip link set dev lo up
echo ""
echo "Display interfaces in h1 namespace"
ip netns exec h1 ifconfig
echo ""
echo "Attach virtual interface h2-eth0 to h2 namespace"
ip link set h2-eth0 netns h2
echo ""
echo "Bring virtual interface h2-eth0 in h2 namespace up"
ip -n h2 link set h2-eth0 up
echo ""
echo "Assign IP address 192.168.0.2 to h2-eth0 in h2 namespace"
ip -n h2 addr add 192.168.0.2/24 dev h2-eth0
echo ""
echo "Bring virtual interface lo in h2 namespace up"
ip netns exec h2 ip link set dev lo up
echo ""
echo "Display interfaces in h2 namespace"
ip netns exec h2 ifconfig
echo ""
echo "From h1, test IP connectivity to 192.168.0.2"
ip netns exec h1 ping -c 2 192.168.0.2
echo ""
echo "From h2, test IP connectivity to 192.168.0.1"
ip netns exec h2 ping -c 2 192.168.0.1
echo ""
echo "Note that Linux bridge defaults to IGMPv2/MLDv1"
echo ""
echo "Enable IGMPv3"
ip link set br0 type bridge mcast_igmp_version 3
echo ""
echo "Enable MLDv2"
ip link set br0 type bridge mcast_mld_version 2
echo ""
echo "Enable bridge multicast snooping"
ip link set br0 type bridge mcast_snooping 1
echo ""
echo "Enable bridge multicast querier"
ip link set br0 type bridge mcast_querier 1
echo ""
echo "Enable bridge multicast statistics"
ip link set br0 type bridge mcast_stats_enabled 1
echo ""
echo "Configure static multicast route 224.0.0.0 on h1 namespace"
ip netns exec h1 route add -net 224.0.0.0 netmask 240.0.0.0 h1-eth0
echo ""
echo "Show ip routing table on h1 namespace"
ip netns exec h1 ip route
echo ""
echo "Multicast addresses on h1 namespace"
ip netns exec h1 ip maddress show
echo ""
echo "Configure static multicast route 224.0.0.0 on h2 namespace"
ip netns exec h2 route add -net 224.0.0.0 netmask 240.0.0.0 h2-eth0
echo ""
echo "Show ip routing table on h2 namespace"
ip netns exec h2 ip route
echo ""
echo "Multicast addresses on h2 namespace"
ip netns exec h2 ip maddress show
echo ""
echo "Generate multicast traffic"
echo ""
echo "Start Multicast receiver receiving from 239.0.0.1 on h1 namespace"
ip netns exec h1 iperf -s -u -B 239.0.0.1 &
echo ""
echo "Show group memberships of h1 namespace"
ip netns exec h1 netstat --groups
echo ""
echo "Start Multicast sender sending to 239.0.0.1 on h2 namespace"
ip netns exec h2 iperf -u -c 239.0.0.1 -b 50m -t 4 -T 10
echo ""
echo "Display h1-eth0 interface network traffic statistics"
ip netns exec h1 ip -s -s link show dev h1-eth0
echo ""
echo "Display h2-eth0 interface network traffic statistics"
ip netns exec h2 ip -s -s link show dev h2-eth0
echo ""
echo "Display multicast database"
bridge mdb show
echo ""
echo "Bring virtual bridge port br0-eth1 down"
ip link set br0-eth1 down
echo ""
echo "Delete virtual port br0-eth1 from bridge br0"
ip link del br0-eth1
echo ""
echo "Bring virtual bridge port br0-eth2 down"
ip link set br0-eth2 down
echo ""
echo "Delete virtual port br0-eth2 from bridge br0"
ip link del br0-eth2
echo ""
echo "Bring bridge br0 down"
ip link set br0 down
echo ""
echo "Delete bridge br0"
ip link delete br0 type bridge
echo ""
echo "Delete h1 namespace"
ip netns delete h1
echo ""
echo "Delete h2 namespace"
ip netns delete h2
echo ""
echo "Check if any namespace(s) is/are left"
ip netns
echo ""
echo "Wait until all links are removed"
sleep 4
echo ""
echo "Check ip links"
ip link
echo ""

