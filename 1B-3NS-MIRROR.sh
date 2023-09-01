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
echo "List interfaces on h3 namespace"
ip netns exec h3 ip link
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
echo "Create virtual Ethernet cable h3-eth0 <---------------> br0-eth3"
ip link add h3-eth0 type veth peer name br0-eth3
echo ""
echo "Add virtual port br0-eth1 to bridge br0"
brctl addif br0 br0-eth1
echo ""
echo "Add virtual port br0-eth2 to bridge br0"
brctl addif br0 br0-eth2
echo ""
echo "Add virtual port br0-eth3 to bridge br0"
brctl addif br0 br0-eth3
echo ""
echo "Bring virtual bridge port br0-eth1 up"
ip link set br0-eth1 up
echo ""
echo "Bring virtual bridge port br0-eth2 up"
ip link set br0-eth2 up
echo ""
echo "Bring virtual bridge port br0-eth3 up"
ip link set br0-eth3 up promisc on arp off multicast off
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
echo "Attach virtual interface h3-eth0 to h3 namespace"
ip link set h3-eth0 netns h3
echo ""
echo "Bring virtual interface h3-eth0 in h3 namespace up"
ip -n h3 link set h3-eth0 up
echo ""
echo "Assign IP address 192.168.0.3 to h3-eth0 in h3 namespace"
ip -n h3 addr add 192.168.0.3/24 dev h3-eth0
echo ""
echo "Bring virtual interface lo in h3 namespace up"
ip netns exec h3 ip link set dev lo up
echo ""
echo "Display interfaces in h3 namespace"
ip netns exec h3 ifconfig
echo ""
echo "From h1, test IP connectivity to 192.168.0.2"
ip netns exec h1 ping -c 4 192.168.0.2
echo ""
echo "From h1, test IP connectivity to 192.168.0.3"
ip netns exec h1 ping -c 4 192.168.0.3
echo ""
echo "Show ip routing table on h1 namespace"
ip netns exec h1 ip route
echo ""
echo "Show ip routing table on h2 namespace"
ip netns exec h2 ip route
echo ""
echo "Show ip routing table on h3 namespace"
ip netns exec h3 ip route
echo ""
echo "Show bridge br0 details"
ip -d -j -p link show br0
echo ""


echo "Namespace to be monitored is attached to bridge interface br0-eth1"
tc qdisc add dev br0-eth1 ingress
echo ""
echo "Ingress packets through bridge interface br0-eth1 are copied to bridge interface br0-eth2"
tc filter add dev br0-eth1 parent ffff: protocol ip u32 match u8 0 0 action mirred egress mirror dev br0-eth2
echo ""
echo "Replace the qdisc attached to root node with a new qdisc of type br0-eth1"
tc qdisc replace dev br0-eth1 parent root prio
echo ""
echo "Show bridge interface br0-eth1 to get the qdisc ID"
tc qdisc show dev br0-eth1
echo ""
echo "Egress packets through bridge interface br0-eth1 are copied to bridge interface br0-eth2"
tc filter add dev br0-eth1 parent 8003: protocol ip u32 match u8 0 0 action mirred egress mirror dev br0-eth2
echo ""
echo "Generate network traffic"
echo ""
echo "Generate unicast traffic"
echo "On h2 namespace, start tcpdump"
ip netns exec h2 xterm &
echo ""
echo "From h3, test IP connectivity to 192.168.0.1"
ip netns exec h3 xterm
echo ""
echo "Check display on h2 xterm"
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
echo "Bring virtual bridge port br0-eth3 down"
ip link set br0-eth3 down
echo ""
echo "Delete virtual port br0-eth3 from bridge br0"
ip link del br0-eth3
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
echo "Delete h3 namespace"
ip netns delete h3
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

