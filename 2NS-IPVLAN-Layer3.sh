echo ""
echo "Brief colored display of all links"
ip -br -c link
echo""
echo "Create ipvlan layer 3 interface ipnet1 from parent interface enp0s3"
ip link add link enp0s3 name ipnet1 type ipvlan mode l3
echo ""
echo "Create ipvlan layer 3 interface ipnet2 from parent interface enp0s3"
ip link add link enp0s3 name ipnet2 type ipvlan mode l3
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
echo "Link ipnet1 ipvlan layer 3 interface to h1 namespace"
ip link set dev ipnet1 netns h1
echo ""
echo "Link ipnet2 ipvlan layer 3 interface to h2 namespace"
ip link set dev ipnet2 netns h2
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
echo "Bring ipvlan layer 3 interface ipnet1 up"
ip -n h1 link set dev ipnet1 up
echo ""
echo "Assign 192.168.0.1/32 to ipnet1 interface"
ip -n h1 address add 192.168.0.1/32 dev ipnet1
echo ""
echo "Display h1 namespace ip address"
ip -n h1 -br -c address ls
echo ""
echo "Bring ipvlan layer 3 interface ipnet2 up"
ip -n h2 link set dev ipnet2 up
echo ""
echo "Assign 192.168.0.2/32 to ipnet2 interface"
ip -n h2 address add 192.168.0.2/32 dev ipnet2
echo ""
echo "Display h2 namespace ip address"
ip -n h2 -br -c address ls
echo ""
echo "Configure default route for h1 namespace"
ip -n h1 route add default dev ipnet1
echo ""
echo "Display ip routing table for h1 namespace"
ip -n h1 -br -c route ls
echo ""
echo "Configure default route for h2 namespace"
ip -n h2 route add default dev ipnet2
echo ""
echo "Display ip routing table for h2 namespace"
ip -n h2 -br -c route ls
echo ""
echo "Display network parameters on h1 namespace"
ip netns exec h1 ip address
echo ""
echo "Display network parameters on h2 namespace"
ip netns exec h2 ip address
echo ""
echo "From h1 namespace, check IP reachability with h2 namespace"
ip netns exec h1 ping -c4 192.168.0.2
echo ""
echo "From h2 namespace, check IP reachability with h1 namespace"
ip netns exec h2 ping -c4 192.168.0.1
echo ""
echo "Create virtual interface ipnet0 linked to parent interface enp0s3"
ip link add link enp0s3 name ipnet0 type ipvlan mode l3
echo ""
echo "Bring virtual interface ipnet0 up"
ip link set dev ipnet0 up
echo ""
echo "Assign 192.168.0.10/32 to virtual interface ipnet0"
ip address add 192.168.0.10/32 dev ipnet0
echo ""
echo "Display root namespace ip addresses"
ip -br -c address
echo ""
echo "From root namespace, add route to 192.168.0.1/32"
ip route add 192.168.0.1/32 dev ipnet0
echo ""
echo "From root namespace, add route to 192.168.0.2/32"
ip route add 192.168.0.2/32 dev ipnet0
echo ""
echo "Display root namespace ip routing table"
ip -br -c route ls
echo ""
echo "from h1 namespace, check ip reachability with 192.168.0.10/32"
ip netns exec h1 ping -c4 192.168.0.10
echo ""
echo "from h2 namespace, check ip reachability with 192.168.0.10/32"
ip netns exec h2 ping -c4 192.168.0.10
echo ""
echo "Might need to disable or configure firewall correctly"
echo "To disable firewall, systemctl stop firewalld"
echo "from root namespace, check IP reachability with h1 namespace"
ping -c4 192.168.0.1
echo ""
echo "from root namespace, check IP reachability with h2 namespace"
ping -c4 192.168.0.2
echo ""

echo "To access the namespaces from an external computer, enter the following routes into that external computer ip routing table."
echo "route add 192.168.0.1 mask 255.255.255.255 192.168.100.70"
echo "route add 192.168.0.2 mask 255.255.255.255 192.168.100.70"
echo "If there is any issue, check the firewall on the computer running the containers"
echo "where 192.168.100.70 is the bridged interface ip address of the virtual machine where the containers are running."
echo "Note that you should leave the containers up and running."
echo ""

echo "Delete virtual interface ipneto"
ip link del link enp0s3 name ipnet0 type ipvlan mode l3
echo "\n"
echo "Bring h1 namespace interface ipnet1 down"
ip netns exec h1 ip link set dev ipnet1 down
echo "\n"
echo "Bring h2 namespace interface ipnet2 down"
ip netns exec h2 ip link set dev ipnet2 down
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
