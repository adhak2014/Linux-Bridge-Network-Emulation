
#						                     __
#h1(192.168.20.1) <----- Patch Cable -----> |  |
#                        					|br| <----> ens0p3(192.168.100.70/24) <----> HR(192.168.100.1/24)
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
echo "Assign 192.168.20.10/24 to bridge br0"
ip addr add 192.168.20.10/24 dev br0
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
echo "Configure route to network 192.168.100.0/24"
ip -n h1 route add 192.168.100.0/24 via 192.168.20.10
echo ""
echo "Display h1 namespace ip routing table"
ip netns exec h1 route -n
echo ""
echo "Configure route to network 192.168.100.0/24"
ip -n h2 route add 192.168.100.0/24 via 192.168.20.10
echo ""
echo "Display h2 namespace ip routing table"
ip netns exec h2 route -n
echo ""
echo "Configure NAT"
iptables --table nat -A POSTROUTING -s 192.168.20.0/24 -j MASQUERADE
echo ""
echo "Enable ip forwarding"
echo 1 > /proc/sys/net/ipv4/ip_forward
echo ""
echo "From h1 namespace, check IP connectivity with 192.168.100.1"
ip netns exec h1 ping -c4 192.168.100.1
echo ""
echo "From h2 namespace, check IP connectivity with 192.168.100.1"
ip netns exec h2 ping -c4 192.168.100.1
echo ""
echo "Configure NAT table"
iptables -t nat --list -n -v
echo ""
echo "Configure h1 namespace default gateway"
ip -n h1 route add default via 192.168.20.10
echo ""
echo "Configure h2 namespace default gateway"
ip -n h2 route add default via 192.168.20.10
echo ""
echo "Display h1 namespace ip routing table"
ip netns exec h1 route -n
echo ""
echo "Display h2 namespace ip routing table"
ip netns exec h2 route -n
echo ""
echo "From h1 namespace, check IP connectivity with 8.8.8.8"
ip netns exec h1 ping -c4 8.8.8.8
echo ""
echo "From h1 namespace, check IP connectivity with 8.8.4.4"
ip netns exec h1 ping -c4 8.8.4.4
echo ""
echo "From h2 namespace, check IP connectivity with 8.8.8.8"
ip netns exec h2 ping -c4 8.8.8.8
echo ""
echo "From h2 namespace, check IP connectivity with 8.8.4.4"
ip netns exec h2 ping -c4 8.8.4.4
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
echo "Bring bridge br0 down"
ip link set br0 down
echo ""
echo "Delete bridge br0"
ip link delete br0 type bridge
echo ""
echo "Bring h1 namespace interface h1-eth0 down"
ip netns exec h1 ip link set dev h1-eth0 down
echo ""
echo "Bring h2 namespace interface h2-eth0 down"
ip netns exec h2 ip link set dev h2-eth0 down
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
echo "Disable ip forwarding"
echo 0 > /proc/sys/net/ipv4/ip_forward
echo ""

sleep 4

echo "Check ip links"
ip link
echo ""













