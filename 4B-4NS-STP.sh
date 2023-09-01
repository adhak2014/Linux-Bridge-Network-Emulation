# Make sure the Linux bridge utilities are installed
# sudo apt install bridge-utils
#
echo "\n"
echo "Create h1 namespace"
ip netns add h1
echo "\n"
echo "Create h2 namespace"
ip netns add h2
echo "\n"
echo "Create h3 namespace"
ip netns add h3
echo "\n"
echo "Create h4 namespace"
ip netns add h4
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
echo "Create bridge br1"
brctl addbr br1
echo "\n"
echo "Create bridge br2"
brctl addbr br2
echo "\n"
echo "Create bridge br3"
brctl addbr br3
echo "\n"
echo "Create bridge br4"
brctl addbr br4
echo "\n"
echo "Enable bridge br1"
ip link set dev br1 up
echo "\n"
echo "Enable bridge br2"
ip link set dev br2 up
echo "\n"
echo "Enable bridge br3"
ip link set dev br3 up
echo "\n"
echo "Enable bridge br4"
ip link set dev br4 up
echo "\n"
echo "Display STP parameters for bridge br1"
brctl showstp br1
echo "\n"
echo "Display STP parameters for bridge br2"
brctl showstp br2
echo "\n"
echo "Display STP parameters for bridge br3"
brctl showstp br3
echo "\n"
echo "Display STP parameters for bridge br4"
brctl showstp br4
echo "\n"
echo "Set STP ageing to 120 sec on Bridge br1"
brctl setageing br1 120
echo "\n"
echo "Set STP ageing to 120 sec on Bridge br2"
brctl setageing br2 120
echo "\n"
echo "Set STP ageing to 120 sec on Bridge br3"
brctl setageing br3 120
echo "\n"
echo "Set STP ageing to 120 sec on Bridge br4"
brctl setageing br4 120
echo "\n"
echo "Enable STP on bridge br1"
brctl stp br1 on
echo "\n"
echo "Enable STP on bridge br2"
brctl stp br2 on
echo "\n"
echo "Enable STP on bridge br3"
brctl stp br3 on
echo "\n"
echo "Enable STP on bridge br4"
brctl stp br4 on
echo "\n"
echo "Display STP parameters for bridge br1"
brctl showstp br1
echo "\n"
echo "Display STP parameters for bridge br2"
brctl showstp br2
echo "\n"
echo "Display STP parameters for bridge br3"
brctl showstp br3
echo "\n"
echo "Display STP parameters for bridge br4"
brctl showstp br4
echo "\n"
echo "Create virtual Ethernet cables between namespaces"
echo "Create virtual Ethernet cable h1-eth0 <---------------> h1-br"
ip link add h1-eth0 type veth peer name h1-br
echo "\n"
echo "Create virtual Ethernet cable h2-eth0 <---------------> h2-br"
ip link add h2-eth0 type veth peer name h2-br
echo "\n"
echo "Create virtual Ethernet cable h3-eth0 <---------------> h3-br"
ip link add h3-eth0 type veth peer name h3-br
echo "\n"
echo "Create virtual Ethernet cable h4-eth0 <---------------> h4-br"
ip link add h4-eth0 type veth peer name h4-br
echo "\n"
echo "Create virtual Ethernet cables between bridges"
echo "Create virtual Ethernet cable br1-eth0 <---------------> br2-eth0"
ip link add br1-eth0 type veth peer name br2-eth0
echo "\n"
echo "Create virtual Ethernet cable br2-eth1 <---------------> br3-eth0"
ip link add br2-eth1 type veth peer name br3-eth0
echo "\n"
echo "Create virtual Ethernet cable br3-eth1 <---------------> br4-eth0"
ip link add br3-eth1 type veth peer name br4-eth0
echo "\n"
echo "Create virtual Ethernet cable br4-eth1 <---------------> br1-eth1"
ip link add br4-eth1 type veth peer name br1-eth1
echo "\n"
echo "Add virtual port h1-br to bridge br1"
brctl addif br1 h1-br
echo "\n"
echo "Add virtual port h2-br to bridge br2"
brctl addif br2 h2-br
echo "\n"
echo "Add virtual port h3-br to bridge br3"
brctl addif br3 h3-br
echo "\n"
echo "Add virtual port h4-br to bridge br4"
brctl addif br4 h4-br
echo "\n"
echo "Add virtual interfaces br1-eth0 and br1-eth1 to bridge br1"
brctl addif br1 br1-eth0 br1-eth1
echo "\n"
echo "Add virtual interfaces br2-eth0 and br2-eth1 to bridge br2"
brctl addif br2 br2-eth0 br2-eth1
echo "\n"
echo "Add virtual interfaces br3-eth0 and br3-eth1 to bridge br3"
brctl addif br3 br3-eth0 br3-eth1
echo "\n"
echo "Add virtual interfaces br4-eth0 and br4-eth1 to bridge br4"
brctl addif br4 br4-eth0 br4-eth1
echo "\n"
echo "Bring virtual port h1-br on bridge br1 up"
ip link set h1-br up
echo "\n"
echo "Bring virtual port h2-br on bridge br2 up"
ip link set h2-br up
echo "\n"
echo "Bring virtual port h3-br on bridge br3 up"
ip link set h3-br up
echo "\n"
echo "Bring virtual port h4-br on bridge br4 up"
ip link set h4-br up
echo "\n"
echo "Bring virtual interface br1-eth0 on bridge br1 up"
ip link set br1-eth0 up
echo "\n"
echo "Bring virtual interface br1-eth1 on bridge br1 up"
ip link set br1-eth1 up
echo "\n"
echo "Bring virtual interface br2-eth0 on bridge br2 up"
ip link set br2-eth0 up
echo "\n"
echo "Bring virtual interface br2-eth1 on bridge br2 up"
ip link set br2-eth1 up
echo "\n"
echo "Bring virtual interface br3-eth0 on bridge br3 up"
ip link set br3-eth0 up
echo "\n"
echo "Bring virtual interface br3-eth1 on bridge br3 up"
ip link set br3-eth1 up
echo "\n"
echo "Bring virtual interface br4-eth0 on bridge br4 up"
ip link set br4-eth0 up
echo "\n"
echo "Bring virtual interface br4-eth1 on bridge br4 up"
ip link set br4-eth1 up
echo "\n"
echo "Display Linux bridges"
brctl show
echo "\n"
echo "Display bridge links"
bridge link
echo "\n"
echo "Attach virtual interface h1-eth0 to h1 namespace"
ip link set h1-eth0 netns h1
echo "\n"
echo "Attach virtual interface h2-eth0 to h2 namespace"
ip link set h2-eth0 netns h2
echo "\n"
echo "Attach virtual interface h3-eth0 to h3 namespace"
ip link set h3-eth0 netns h3
echo "\n"
echo "Attach virtual interface h4-eth0 to h4 namespace"
ip link set h4-eth0 netns h4
echo "\n"
echo "Bring virtual interface h1-eth0 in h1 namespace up"
ip -n h1 link set h1-eth0 up
echo "\n"
echo "Bring virtual interface h2-eth0 in h2 namespace up"
ip -n h2 link set h2-eth0 up
echo "\n"
echo "Bring virtual interface h3-eth0 in h3 namespace up"
ip -n h3 link set h3-eth0 up
echo "\n"
echo "Bring virtual interface h4-eth0 in h4 namespace up"
ip -n h4 link set h4-eth0 up
echo "\n"
echo "Bring virtual interface lo in h1 namespace up"
ip netns exec h1 ip link set dev lo up
echo "\n"
echo "Bring virtual interface lo in h2 namespace up"
ip netns exec h2 ip link set dev lo up
echo "\n"
echo "Bring virtual interface lo in h3 namespace up"
ip netns exec h3 ip link set dev lo up
echo "\n"
echo "Bring virtual interface lo in h4 namespace up"
ip netns exec h4 ip link set dev lo up
echo "\n"
echo "Display bridge br1 MAC address Table"
brctl showmacs br1
echo "\n"
echo "Display bridge br2 MAC address Table"
brctl showmacs br2
echo "\n"
echo "Display bridge br3 MAC address Table"
brctl showmacs br3
echo "\n"
echo "Display bridge br4 MAC address Table"
brctl showmacs br4
echo "\n"
echo "Assign IP address 10.0.0.1/24 to virtual interface h1-eth0 in h1 namespace"
ip -n h1 addr add 10.0.0.1/24 dev h1-eth0
echo "\n"
echo "Check h1 namespace IP configuration"
ip netns exec h1 ifconfig
echo "\n"
echo "Assign IP address 10.0.0.2/24 to virtual interface h2-eth0 in h2 namespace"
ip -n h2 addr add 10.0.0.2/24 dev h2-eth0
echo "\n"
echo "Check h2 namespace IP configuration"
ip netns exec h2 ifconfig
echo "\n"
echo "Assign IP address 10.0.0.3/24 to virtual interface h3-eth0 in h3 namespace"
ip -n h3 addr add 10.0.0.3/24 dev h3-eth0
echo "\n"
echo "Check h3 namespace IP configuration"
ip netns exec h3 ifconfig
echo "\n"
echo "Assign IP address 10.0.0.4/24 to virtual interface h4-eth0 in h4 namespace"
ip -n h4 addr add 10.0.0.4/24 dev h4-eth0
echo "\n"
echo "Check h4 namespace IP configuration"
ip netns exec h4 ifconfig
echo "\n"

echo "Pause 40 seconds to allow STP convergence"
sleep 40
echo "\n"

echo "Check IP connectivity from h1 namespace to h2 namespace at 10.0.0.2"
ip netns exec h1 ping -c1 10.0.0.2
echo "\n"
echo "Check IP connectivity from h1 namespace to h3 namespace at 10.0.0.3"
ip netns exec h1 ping -c1 10.0.0.3
echo "\n"
echo "Check IP connectivity from h1 namespace to h4 namespace at 10.0.0.4"
ip netns exec h1 ping -c1 10.0.0.4
echo "\n"
echo "Display bridges links"
bridge link
echo "\n"
echo "Display bridge br1 STP parameters"
brctl showstp br1
echo "\n"
echo "Display bridge br2 STP parameters"
brctl showstp br2
echo "\n"
echo "Display bridge br3 STP parameters"
brctl showstp br3
echo "\n"
echo "Display bridge br4 STP parameters"
brctl showstp br4
echo "\n"
echo "Detach virtual port h1-br from bridge br1"
ip link set h1-br nomaster
echo "\n"
echo "Detach virtual port h2-br from bridge br2"
ip link set h2-br nomaster
echo "\n"
echo "Detach virtual port h3-br from bridge br3"
ip link set h3-br nomaster
echo "\n"
echo "Detach virtual port h4-br from bridge br4"
ip link set h4-br nomaster
echo "\n"
echo "Detach virtual interface br1-eth0 from bridge br1"
ip link set br1-eth0 nomaster
echo "\n"
echo "Detach virtual interface br1-eth1 from bridge br1"
ip link set br1-eth1 nomaster
echo "\n"
echo "Detach virtual interface br2-eth0 from bridge br2"
ip link set br2-eth0 nomaster
echo "\n"
echo "Detach virtual interface br2-eth1 from bridge br2"
ip link set br2-eth1 nomaster
echo "\n"
echo "Detach virtual interface br3-eth0 from bridge br3"
ip link set br3-eth0 nomaster
echo "\n"
echo "Detach virtual interface br3-eth1 from bridge br3"
ip link set br3-eth1 nomaster
echo "\n"
echo "Detach virtual interface br4-eth0 from bridge br4"
ip link set br4-eth0 nomaster
echo "\n"
echo "Detach virtual interface br4-eth1 from bridge br4"
ip link set br4-eth1 nomaster
echo "\n"
echo "Delete virtual Ethernet cable br1-eth0 <---------------> br2-eth0"
ip link del br1-eth0 type veth peer name br2-eth0
echo "\n"
echo "Delete virtual Ethernet cable br2-eth1 <---------------> br3-eth0"
ip link del br2-eth1 type veth peer name br3-eth0
echo "\n"
echo "Delete virtual Ethernet cable br3-eth1 <---------------> br4-eth0"
ip link del br3-eth1 type veth peer name br4-eth0
echo "\n"
echo "Delete virtual Ethernet cable br4-eth1 <---------------> br1-eth1"
ip link del br4-eth1 type veth peer name br1-eth1
echo "\n"
echo "Bring bridge br1 virtual interface down"
ip link set br1 down
echo "\n"
echo "Bring bridge br2 virtual interface down"
ip link set br2 down
echo "\n"
echo "Bring bridge br3 virtual interface down"
ip link set br3 down
echo "\n"
echo "Bring bridge br4 virtual interface down"
ip link set br4 down
echo "\n"
echo "Delete bridge br1"
ip link delete br1 type bridge
echo "\n"
echo "Delete bridge br2"
ip link delete br2 type bridge
echo "\n"
echo "Delete bridge br3"
ip link delete br3 type bridge
echo "\n"
echo "Delete bridge br4"
ip link delete br4 type bridge
echo "\n"
echo "Check if any Linux bridge(s) is/are left"
brctl show
echo "\n"
echo "Bring h1 namespace interface h1-eth0 down"
ip netns exec h1 ip link set dev h1-eth0 down
echo "\n"
echo "Bring h2 namespace interface h2-eth0 down"
ip netns exec h2 ip link set dev h2-eth0 down
echo "\n"
echo "Bring h3 namespace interface h3-eth0 down"
ip netns exec h3 ip link set dev h3-eth0 down
echo "\n"
echo "Bring h4 namespace interface h4-eth0 down"
ip netns exec h4 ip link set dev h4-eth0 down
echo "\n"
echo "Delete h1 namespace"
ip netns delete h1
echo "\n"
echo "Delete h2 namespace"
ip netns delete h2
echo "\n"
echo "Delete h3 namespace"
ip netns delete h3
echo "\n"
echo "Delete h4 namespace"
ip netns delete h4
echo "\n"
echo "Check if any namespace(s) is/are left"
ip netns
echo "\n"

slee 5

echo "Check ip links"
ip link
echo "\n"
