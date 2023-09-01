echo ""
echo "Brief colored display of all links"
ip -br -c link
echo""
echo "Create ipvlan layer 3 interface ipif1 from parent interface enp0s3"
ip link add link enp0s3 name ipif1 type ipvlan mode l3
echo ""
echo "Create ipvlan layer 3 interface ipif2 from parent interface enp0s3"
ip link add link enp0s3 name ipif2 type ipvlan mode l3
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
echo "Link ipif1 ipvlan layer 3 interface to h1 namespace"
ip link set dev ipif1 netns h1
echo ""
echo "Link ipif2 ipvlan layer 3 interface to h2 namespace"
ip link set dev ipif2 netns h2
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
echo "Bring ipvlan layer 3 interface ipif1 up"
ip -n h1 link set dev ipif1 up
echo ""
echo "Assign 192.168.200.1/24 to ipif1 interface"
ip -n h1 address add 192.168.200.1/24 dev ipif1
echo ""
echo "Display h1 namespace ip address"
ip -n h1 -br -c address ls
echo ""
echo "Bring ipvlan layer 3 interface ipif2 up"
ip -n h2 link set dev ipif2 up
echo ""
echo "Assign 192.168.201.1/24 to ipif2 interface"
ip -n h2 address add 192.168.201.1/24 dev ipif2
echo ""
echo "Display h2 namespace ip address"
ip -n h2 -br -c address ls
echo ""
echo "Configure default route for h1 namespace"
ip -n h1 route add default dev ipif1
echo ""
echo "Display ip routing table for h1 namespace"
ip -n h1 -br -c route ls
echo ""
echo "Configure default route for h2 namespace"
ip -n h2 route add default dev ipif2
echo ""
echo "Display ip routing table for h2 namespace"
ip -n h2 -br -c route ls
echo ""
echo "From h1 namespace, check IP reachability with h2 namespace"
ip netns exec h1 ping -c4 192.168.201.1
echo ""
echo "From h2 namespace, check IP reachability with h1 namespace"
ip netns exec h2 ping -c4 192.168.200.1
echo ""
echo "Create virtual interface ipif0 linked to parent interface enp0s3"
ip link add link enp0s3 name ipif0 type ipvlan mode l3
echo ""
echo "Bring virtual interface ipif0 up"
ip link set dev ipif0 up
echo ""
echo "Assign 192.168.202.1/24 to virtual interface ipif0"
ip address add 192.168.202.1/24 dev ipif0
echo ""
echo "Display root namespace ip addresses"
ip -br -c address
echo ""
echo "From root namespace, add route to 192.168.200.0/24"
ip route add 192.168.200.0/24 dev ipif0
echo ""
echo "From root namespace, add route to 192.168.201.0/24"
ip route add 192.168.201.0/24 dev ipif0
echo ""
echo "Display root namespace ip routing table"
ip -br -c route ls
echo ""
echo "from h1 namespace, check ip reachability with 192.168.201.1/24"
ip netns exec h1 ping -c2 192.168.201.1
echo ""
echo "from h2 namespace, check ip reachability with 192.168.200.1/24"
ip netns exec h2 ping -c2 192.168.200.1
echo ""
echo "From the root namespace, check IP reachability to h1 namespace"
ping -c2 192.168.200.1
echo ""
echo "From the root namespace, check IP reachability to h2 namespace"
ping -c2 192.168.201.1
echo ""
echo "Delete virtual interface ipif0"
ip link del link enp0s3 name ipif0 type ipvlan mode l3
echo "\n"
echo "Bring h1 namespace interface ipif1 down"
ip netns exec h1 ip link set dev ipif1 down
echo "\n"
echo "Bring h2 namespace interface ipif2 down"
ip netns exec h2 ip link set dev ipif2 down
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
