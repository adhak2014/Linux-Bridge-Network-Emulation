echo ""
echo "Create virtual Ethernet cable veth1 <---------------> vpeer1"
ip link add veth1 type veth peer name vpeer1
echo ""
echo "Create virtual Ethernet cable veth2 <---------------> vpeer2"
ip link add veth2 type veth peer name vpeer2
echo ""

echo "Assign 10.200.1.1/24 to veth1"
ip addr add 10.200.1.1/24 dev veth1
echo ""
echo "Bring virtual interface veth1 up"
ip link set veth1 up
echo ""

echo "Assign 10.200.2.1/24 to veth2"
ip addr add 10.200.2.1/24 dev veth2
echo ""
echo "Bring virtual interface veth2 up"
ip link set veth2 up
echo ""

echo "Create h1 namespace"
ip netns add h1
echo ""
echo "Create h2 namespace"
ip netns add h2
echo ""

echo "Link vpeer1 to h1 namespace"
ip link set vpeer1 netns h1
echo ""
echo "Link vpeer2 to h2 namespace"
ip link set vpeer2 netns h2
echo ""

echo "Assign 10.200.1.10/24 to vpeer1"
ip netns exec h1 ip addr add 10.200.1.10/24 dev vpeer1
echo ""
echo "Bring virtual interface vpeer1 up"
ip netns exec h1 ip link set vpeer1 up
echo ""
echo "Bring virtual interface lo up"
ip netns exec h1 ip link set lo up
echo ""
echo "Configure default gateway on h1 namespace"
ip netns exec h1 ip route add default via 10.200.1.1
echo ""

echo "Assign 10.200.2.10/24 to vpeer2"
ip netns exec h2 ip addr add 10.200.2.10/24 dev vpeer2
echo ""
echo "Bring virtual interface vpeer2 up"
ip netns exec h2 ip link set vpeer2 up
echo ""
echo "Bring virtual interface lo up"
ip netns exec h2 ip link set lo up
echo ""
echo "Configure default gateway on h2 namespace"
ip netns exec h2 ip route add default via 10.200.2.1
echo ""

echo "Enable IP-forwarding"
echo 1 > /proc/sys/net/ipv4/ip_forward
echo ""

echo "Flush forward rules"
iptables -P FORWARD DROP
iptables -F FORWARD
echo ""
echo "Flush nat rules"
iptables -t nat -F
echo ""

echo "Enable masquerading of 10.200.1.10/24 and 10.200.2.10/24"
iptables -t nat -A POSTROUTING -s 10.200.1.10/24 -o enp0s3 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.200.2.10/24 -o enp0s3 -j MASQUERADE
echo ""
iptables -A FORWARD -i enp0s3 -o veth1 -j ACCEPT
iptables -A FORWARD -i enp0s3 -o veth2 -j ACCEPT
iptables -A FORWARD -o enp0s3 -i veth1 -j ACCEPT
iptables -A FORWARD -o enp0s3 -i veth2 -j ACCEPT
echo ""
echo "From h1, test IP connectivity to 192.168.100.1"
ip netns exec h1 ping -c2 192.168.100.1
echo ""
echo "From h1, test IP connectivity to 8.8.8.8"
ip netns exec h1 ping -c2 8.8.8.8
echo ""
echo "From h1, test IP connectivity to 8.8.4.4"
ip netns exec h1 ping -c2 8.8.4.4
echo ""

echo "From h2, test IP connectivity to 192.168.100.1"
ip netns exec h2 ping -c2 192.168.100.1
echo ""
echo "From h2, test IP connectivity to 8.8.8.8"
ip netns exec h2 ping -c2 8.8.8.8
echo ""
echo "From h2, test IP connectivity to 8.8.4.4"
ip netns exec h2 ping -c2 8.8.4.4
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
