echo ""
echo "Display iplinks"
ip -c -br link show
echo ""
echo "Create a new bridge br0"
ip link add name br0 type bridge
echo ""
echo "Display bridge br0 link"
ip -c link show br0
echo ""
echo "Display bridge br0 details"
ip -d -c link show br0
echo ""
echo "Create a virtual Ethernet cable br0-eth1 <---------------> h1-eth0"
ip link add name br0-eth1 type veth peer h1-eth0
echo ""
echo "Create a virtual Ethernet cable br0-eth2 <---------------> h2-eth0"
ip link add name br0-eth2 type veth peer h2-eth0
echo ""
echo "Display brief link information"
ip -c -br link show type veth
echo ""
echo "Create a new namespace h1"
ip netns add h1
echo ""
echo "Create a new namespace h2"
ip netns add h2
echo ""
echo "List created namespaces"
ip netns ls
echo ""
echo "Link device h1-eth0 to h1 namespace"
ip link set dev h1-eth0 netns h1
echo ""
echo "Display h1 namespace link"
ip -n h1 link show
echo ""
echo "Display h1 namespace brief link information"
ip -n h1 -c -br link show
echo ""
echo "Bring virtual interface lo in h1 namespace up"
ip netns exec h1 ip link set dev lo up
echo "\n"
echo "Bring device h1-eth0 up"
ip -n h1 link set dev h1-eth0 up
echo ""
echo "Assign 192.168.0.1/24 to device h1-eth0"
ip -n h1 address add 192.168.0.1/24 dev h1-eth0
echo ""
echo "Display h1 namespace address"
ip -n h1 -c -br address show
echo ""
echo "Display h1 namespace link"
ip -n h1 link show
echo ""
echo "Link device h2-eth0 to h2 namespace"
ip link set dev h2-eth0 netns h2
echo ""
echo "Display h2 namespace link"
ip -n h2 link show
echo ""
echo "Display h2 namespace brief link information"
ip -n h2 -c -br link show
echo ""
echo "Bring virtual interface lo in h2 namespace up"
ip netns exec h2 ip link set dev lo up
echo "\n"
echo "Bring device h2-eth0 up"
ip -n h2 link set dev h2-eth0 up
echo ""
echo "Assign 192.168.0.1/24 to device h2-eth0"
ip -n h2 address add 192.168.0.2/24 dev h2-eth0
echo ""
echo "Display h2 namespace address"
ip -n h2 -c -br address show
echo ""
echo "Display h1 namespace link"
ip -n h2 link show
echo ""
echo "Display bridge br0 link"
ip -c -br link show type bridge
echo ""
echo "Link device br0-eth1 to bridge br0"
ip link set dev br0-eth1 master br0
echo ""
echo "Link device br0-eth2 to bridge br0"
ip link set dev br0-eth2 master br0
echo ""
echo "Bring device br0-eth1 up"
ip link set dev br0-eth1 up
echo ""
echo "Bring device br0-eth2 up"
ip link set dev br0-eth2 up
echo ""
echo "Display link"
ip -c -br link show
echo ""
echo "Bring bridge br0 up"
ip link set dev br0 up
echo ""
echo "Display link"
ip -c -br link show
echo ""
echo "From h1 namespace, check IP reachability with h2 namespace"
ip netns exec h1 ping -c2 192.168.0.2
echo ""
echo "Display bridge br0 brief link information"
ip -c -br link show br0
echo ""
echo "Display bridge  br0 detailed link information"
ip -c -d link show br0
echo ""
echo "Display bridge br0 link"
bridge link show br0
echo ""
echo "Display bridge br0 forwarding database"
bridge fdb show br0
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

sleep 5

echo "Check ip links"
ip link
echo "\n"



