#https://medium.com/@abhishek.amjeet/container-networking-using-namespaces-part1-859d317ca1b8
#dev(192.168.20.1) <----- Patch Cable -----> prod(192.168.20.2)

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
echo "Create virtual Ethernet cable h1-eth0 <--------------- h2-eth0>"
ip link add h1-eth0 type veth peer name h2-eth0
echo ""
echo "Link h1-eth0 to h1 namespace"
ip link set h1-eth0 netns h1
echo ""
echo "Link h2-eth0 to h2 namespace"
ip link set h2-eth0 netns h2
echo ""
echo "Assign 192.168.20.1/24 to h1 namespace"
ip -n h1 addr add 192.168.20.1 dev h1-eth0
echo ""
echo "Assign 192.168.20.2/24 to h2 namespace"
ip -n h2 addr add 192.168.20.2 dev h2-eth0
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
echo "Configure default route in h1 namespace"
ip netns exec h1 ip route add default via 192.168.20.1 dev h1-eth0
echo ""
echo "Configure default route in h2 namespace"
ip netns exec h2 ip route add default via 192.168.20.2 dev h2-eth0
echo ""
echo "Dislay ip routing tables of all namespaces"
ip --all netns exec route -n
echo ""
echo "from h1, test ip reachability to h2"
ip netns exec h1 ping 192.168.20.2 -c 4
echo ""
echo "Dislay arp caches of all namespaces"
ip --all netns exec arp
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
echo "Check ip links"
ip link
echo ""
