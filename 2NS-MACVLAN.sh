echo "To allow external devices to communicate with the namespaces h1 and h2, you need to enable"
echo "promiscous mode in the VM Manager under Setting, Network, Advanced and then Promiscous Mode: Allow All."
echo "You need to enter a secondary IP address to the Windows host NIC such as 192.168.22.100/24"
echo "Configure a static route route add 192.168.22.0 mask 255.255.255.0 192.168.22.100 on the same Windows host."
echo "Using a command prompt, ping to containers IPs. There should be replies."
echo "Note that in this case, the VM is bridged to the physical NIC of the Windows host." 

echo ""
echo "Turn on promiscous mode on parent interface enp0s3"
ip link set dev enp0s3 promisc on
echo ""
echo "Display detailed information about parent interface enp0s3"
ip -d -c link show enp0s3
echo ""
echo "Brief colored display of all links"
ip -br -c link show
echo""
echo "Brief colored display of parent link enp0s3"
ip address show enp0s3
echo""
echo "Create macvlan interface macif1 from parent interface enp0s3"
ip link add link enp0s3 name macif1 type macvlan mode bridge
echo ""
echo "Create macvlan interface macif2 from parent interface enp0s3"
ip link add link enp0s3 name macif2 type macvlan mode bridge
echo ""
echo "Display all Macvlan links"
ip -d link show type macvlan
echo ""
echo "Display all available namespaces"
ip netns ls
echo ""
echo "Create h1 namespace"
ip netns add h1
echo ""
echo "Create h2 namespace"
ip netns add h2
echo ""
echo "Display all namespaces"
ip netns show
echo ""
echo "Link macif1 macvlan interface to h1 namespace"
ip link set dev macif1 netns h1
echo ""
echo "Link macif2 macvlan interface to h2 namespace"
ip link set dev macif2 netns h2
echo ""
echo "Brief colored display of all links"
ip -br -c link ls
echo""
echo "Brief colored display of links in h1 namespace"
ip -n h1 -br -c link ls
echo ""
echo "Brief colored display of links in h2 namespace"
ip -n h2 -br -c link ls
echo ""
echo "For Macvlan bridge mode the subnet values need to match the NIC's interface of the Host"
echo "Bring macvlan interface macif1 up"
ip -n h1 link set dev macif1 up
echo ""
echo "Assign 192.168.22.201/24  to macif1 interface"
ip -n h1 address add 192.168.22.201/24 dev macif1
echo ""
echo "Configure default route for h1 namespace"
ip -n h1 route add default dev macif1
echo ""
echo "Display h1 namespace link"
ip netns exec h1 ip -br link show
echo ""
echo "Bring macvlan interface macif2 up"
ip -n h2 link set dev macif2 up
echo ""
echo "Assign 192.168.22.202/24 to macif2 interface"
ip -n h2 address add 192.168.22.202/24 dev macif2
echo ""
echo "Configure default route for h2 namespace"
ip -n h2 route add default dev macif2
echo ""
echo "Display h2 namespace link"
ip netns exec h2 ip -br link show
echo ""
echo "From h1 namespace, check IP reachability with h2 namespace"
ip netns exec h1 ping -c4 192.168.22.202
echo ""
echo "From h2 namespace, check IP reachability with h1 namespace"
ip netns exec h2 ping -c4 192.168.22.201
echo ""
echo "Create virtual interface macif0 from parent interface enp0s3"
ip link add link enp0s3 name macif0 type macvlan mode bridge
echo ""
echo "Bring virtual interface macif0 up"
ip link set dev macif0 up
echo ""
echo "Display macvlan interface in root namespace"
ip link show type macvlan
echo ""
echo "Assign 192.168.22.200/24 to virtual interface macif0"
ip address add 192.168.22.200/24 dev macif0
echo ""
echo "Display root namespace ip addresses"
ip -br -c address
echo ""
echo "From h1 namespace, check IP reachability with 192.168.22.200"
ip netns exec h1 ping -c4 192.168.22.200
echo ""
echo "From h2 namespace, check IP reachability with 192.168.22.200"
ip netns exec h2 ping -c4 192.168.22.200
echo ""
echo "from root namespace, check IP reachability with h1 namespace"
ping -c2 192.168.22.201
echo ""
echo "from root namespace, check IP reachability with h2 namespace"
ping -c2 192.168.22.202
echo ""

sleep 300

echo "Turn off promiscous mode on parent interface enp0s3"
ip link set dev enp0s3 promisc off
echo ""
echo "Delete virtual interface macif0"
ip link del link enp0s3 name macif0
echo "\n"
echo "Bring h1 namespace interface macif1 down"
ip netns exec h1 ip link set dev macif1 down
echo "\n"
echo "Bring h2 namespace interface macif2 down"
ip netns exec h2 ip link set dev macif2 down
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
