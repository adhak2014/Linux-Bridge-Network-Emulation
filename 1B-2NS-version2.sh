echo "\n"
echo "Create h1 namespace"
ip netns add h1
echo "\n"
echo "Create h2 namespace"
ip netns add h2
echo "\n"
echo "Display all namespaces"
ip netns
echo "\n"
echo "Display again all namespaces"
ls /var/run/netns
echo "\n"
echo "List interfaces on the host"
ip link
echo "\n"
echo "List interfaces on h1 namespace"
ip netns exec h1 ip link
echo "\n"
echo "List interfaces on h2 namespace"
ip netns exec h2 ip link
echo "\n"
echo "Create bridge br0"
brctl addbr br0
echo "\n"
echo "Enable bridge br0"
ip link set dev br0 up
echo "\n"
echo "Create virtual Ethernet cable h1-eth0 <---------------> h1-br"
ip link add h1-eth0 type veth peer name h1-br
echo "\n"
echo "Create virtual Ethernet cable h2-eth0 <---------------> h2-br"
ip link add h2-eth0 type veth peer name h2-br
echo "\n"
echo "Add virtual port h1-br to bridge br0"
brctl addif br0 h1-br
echo "\n"
echo "Add virtual port h2-br to bridge br0"
brctl addif br0 h2-br
echo "\n"
echo "Bring virtual bridge port h1-br up"
ip link set h1-br up
echo "\n"
echo "Bring virtual bridge port h2-br up"
ip link set h2-br up
echo "\n"
echo "Assign IP address to bridge br0"
ip addr add 192.168.1.1/24 dev br0
echo "\n"
echo "Display Linux bridge"
brctl show
echo "\n"
echo "Display bridge links"
bridge link
echo "\n"
echo "Attach virtual interface h1-eth0 to h1 namespace"
ip link set h1-eth0 netns h1
echo "\n"
echo "Bring virtual interface h1-eth0 in h1 namespace up"
ip -n h1 link set h1-eth0 up
echo "\n"
echo "Assign IP address 192.168.0.1 to h1-eth0 in h1 namespace"
ip -n h1 addr add 192.168.0.1/24 dev h1-eth0
echo "\n"
echo "Bring virtual interface lo in h1 namespace up"
ip netns exec h1 ip link set dev lo up
echo "\n"
echo "Display interfaces in h1 namespace"
ip netns exec h1 ifconfig
echo "\n"
echo "Attach virtual interface h2-eth0 to h2 namespace"
ip link set h2-eth0 netns h2
echo "\n"
echo "Bring virtual interface h2-eth0 in h2 namespace up"
ip -n h2 link set h2-eth0 up
echo "\n"
echo "Assign IP address 192.168.0.2 to h2-eth0 in h2 namespace"
ip -n h2 addr add 192.168.0.2/24 dev h2-eth0
echo "\n"
echo "Bring virtual interface lo in h2 namespace up"
ip netns exec h2 ip link set dev lo up
echo "\n"
echo "Display interfaces in h2 namespace"
ip netns exec h2 ifconfig
echo "\n"
echo "From h1, test IP connectivity to 192.168.0.2"
ip netns exec h1 ping -c2 192.168.0.2
echo "\n"
echo "From h2, test IP connectivity to 192.168.0.1"
ip netns exec h2 ping -c2 192.168.0.1
echo "\n"

#echo "Enter h1 bash shell"
#ip netns exec h1 bash
#echo "\n"
#echo "Start h1 xterm"
#ip netns exec h1 xterm
#echo "\n"
#echo "Start h2 xterm"
#ip netns exec h2 xterm
#echo "\n"

echo "Bring virtual bridge port h1-br down"
ip link set h1-br down
echo "\n"
echo "Remove virtual port h1-br from bridge br0"
ip link set h1-br nomaster
echo "\n"
echo "Bring virtual bridge port h2-br down"
ip link set h2-br down
echo "\n"
echo "Remove virtual port h2-br from bridge br0"
ip link set h2-br nomaster
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
echo "Check ip links"
ip link
echo "\n"

