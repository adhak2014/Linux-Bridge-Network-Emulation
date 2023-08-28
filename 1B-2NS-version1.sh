#                                            __
#h1(192.168.20.1) <----- Patch Cable -----> |  |
#				            |br|
#h2(192.168.20.2) <----- Patch Cable -----> |__|
#
echo ""
echo "Create bridge br0"
brctl addbr br0
echo ""
echo "Enable bridge br0"
ip link set dev br0 up
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
echo "Link h1-eth0 to h1 namespace"
ip link set h1-eth0 netns h1
echo ""
echo "Link h2-eth0 to h2 namespace"
ip link set h2-eth0 netns h2
echo ""
echo "Assign 192.168.20.1/24 to h1 namespace"
ip -n h1 addr add 192.168.20.1/24 dev h1-eth0
echo ""
echo "Assign 192.168.20.2/24 to h2 namespace"
ip -n h2 addr add 192.168.20.2/24 dev h2-eth0
echo ""
echo "Bring h1-eth0 in h1 namespace up"
ip -n h1 link set h1-eth0 up
echo ""
echo "Bring lo in h1 namespace up"
ip -n h1 link set lo up
echo ""
echo "Bring h2-eth0 in h2 namespace up"
ip -n h2 link set h2-eth0 up
echo ""
echo "Bring lo in h2 namespace up"
ip -n h2 link set lo up
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
echo "Check network links in all namespaces"
ip --all netns exec ip link
echo ""
echo "Check IP address in all namespaces"
ip --all netns exec ip addr
echo ""
echo "Dislay ip routing tables of all namespaces"
ip --all netns exec route
echo ""
echo "from h1, test ip reachability to h2"
ip netns exec h1 ping 192.168.20.2 -c 4
echo ""
echo "Display ARP caches of all namespaces"
ip --all netns exec arp
echo ""
echo "Display IP routing tables of all namespaces"
ip --all netns exec route
echo ""
echo "Display bridge br0"
brctl show br0
echo ""
echo "Display MAC addresses of bridge br0"
brctl showmacs br0
echo ""
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
echo "Delete h1 namespace"
ip netns delete h1
echo "\n"
echo "Delete h2 namespace"
ip netns delete h2
echo "\n"
echo "Check if any namespace(s) is/are left"
ip netns
echo "\n"

sleep 4

echo "Check ip links"
ip link
echo "\n"
