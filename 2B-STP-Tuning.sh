echo "\n"
echo "Show Linux bridge version"
bridge -V
echo "\n"
echo "Show help information about the bridge object"
ip link help bridge
echo "\n"
echo "Another way to show help information about the bridge object"
bridge -h
echo "Create virtual Ethernet cable br0-eth1 <---------------> br1-eth1"
ip link add br0-eth1 type veth peer name br1-eth1
echo "\n"
echo "Create virtual Ethernet cable br0-eth2 <---------------> br1-eth2"
ip link add br0-eth2 type veth peer name br1-eth2
echo "\n"
echo "Create a bridge named br0"
ip link add br0 type bridge
echo "\n"
echo "Create a bridge named br1"
ip link add br1 type bridge
echo "\n"
echo "Show all bridges"
brctl show
echo "\n"
echo "Show bridge br0 details"
ip -d link show br0
echo "\n"
echo "Show bridge br1 details"
ip -d link show br1
echo "\n"
echo "Show bridge br0 details in a pretty JSON format"
ip -j -p -d link show br0
echo "\n"
echo "Show bridge br1 details in a pretty JSON format"
ip -j -p -d link show br1
echo "\n"
echo "Add interface br0-eth1 to bridge br0"
ip link set br0-eth1 master br0
echo "\n"
echo "Add interface br0-eth2 to bridge br0"
ip link set br0-eth2 master br0
echo "\n"
echo "Add interface br1-eth1 to bridge br1"
ip link set br1-eth1 master br1
echo "\n"
echo "Add interface br1-eth2 to bridge br1"
ip link set br1-eth2 master br1
echo "\n"
echo "Enable STP on bridge br0"
ip link set br0 type bridge stp_state 1
echo "\n"
echo "Enable STP on bridge br1"
ip link set br1 type bridge stp_state 1
echo "\n"
echo "Change STP hello timer on bridge br0"
ip link set br0 type bridge hello_time 300
echo "\n"
echo "Change STP hello timer on bridge br1"
ip link set br1 type bridge hello_time 300
echo "\n"
echo "Show the hello time on bridge br0"
ip -j -p -d link show br0 | grep \"hello_time\"
echo "\n"
echo "Show the hello time on bridge br1"
ip -j -p -d link show br1 | grep \"hello_time\"
echo "\n"
echo "Change STP forward delay on bridge br0"
ip link set br0 type bridge forward_delay 1000
echo "\n"
echo "Change STP forward delay on bridge br1"
ip link set br1 type bridge forward_delay 1000
echo "\n"
echo "Show the forward delay on bridge br0"
ip -j -p -d link show br0 | grep \"forward_delay\"
echo "\n"
echo "Show the forward delay on bridge br1"
ip -j -p -d link show br1 | grep \"forward_delay\"
echo "\n"
echo "Change STP maximum age on bridge br0"
ip link set br0 type bridge max_age 1000
echo "\n"
echo "Change STP maximum age on bridge br1"
ip link set br1 type bridge max_age 1000
echo "\n"
echo "Show the maximum age on bridge br0"
ip -j -p -d link show br0 | grep \"max_age\"
echo "\n"
echo "Show the maximum age on bridge br1"
ip -j -p -d link show br1 | grep \"max_age\"
echo "\n"
echo "Change STP ageing time on bridge br0"
ip link set br0 type bridge ageing_time 15000
echo "\n"
echo "Change STP ageing time on bridge br1"
ip link set br1 type bridge ageing_time 15000
echo "\n"
echo "Show the ageing time on bridge br0"
ip -j -p -d link show br0 | grep \"ageing_time\"
echo "\n"
echo "Show the ageing time on bridge br1"
ip -j -p -d link show br1 | grep \"ageing_time\"
echo "\n"
echo "Change STP priority on bridge br0"
ip link set br0 type bridge priority 16384
echo "\n"
echo "Change STP priority on bridge br1"
ip link set br1 type bridge priority 8192
echo "\n"
echo "Show the priority on bridge br0"
ip -j -p -d link show br0 | grep \"priority\"
echo "\n"
echo "Show the priority on bridge br1"
ip -j -p -d link show br1 | grep \"priority\"
echo "\n"
echo "Wait 40 seconds for STP convergence"
sleep 40
echo "\n"
echo "Show all bridges"
brctl show
echo "\n"
echo "Show bridge br0 STP"
brctl showstp br0
echo "\n"
echo "Show bridge br1 STP"
brctl showstp br1
echo "\n"
echo "Show the STP blocking state bridge br0"
ip -j -p -d link show br0 | grep root_port
echo "\n"
echo "Show the STP blocking state bridge br1"
ip -j -p -d link show br1 | grep root_port
echo "\n"
echo "Show all bridges links"
bridge link show
echo "\n"
echo "Disable STP on bridge br0"
ip link set br0 type bridge stp_state 0
echo "\n"
echo "Disable STP on bridge br1"
ip link set br1 type bridge stp_state 0
echo "\n"
echo "Show bridge br0 details in a pretty JSON format"
ip -j -p -d link show br0
echo "\n"
echo "Show bridge br1 details in a pretty JSON format"
ip -j -p -d link show br1
echo "\n"
echo "Show bridge br0 details"
brctl show br0
echo "\n"
echo "Show bridge br1 details"
brctl show br1
echo "\n"
echo "Show bridge br0 mac address table"
brctl showmacs br0
echo "\n"
echo "Show bridge br1 mac address table"
brctl showmacs br1
echo "\n"
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
echo "Bring virtual bridge port br1-eth1 down"
ip link set br1-eth1 down
echo "\n"
echo "Remove virtual port br1-eth1 from bridge br1"
ip link set br1-eth1 nomaster
echo "\n"
echo "Bring virtual bridge port br1-eth2 down"
ip link set br1-eth2 down
echo "\n"
echo "Remove virtual port br1-eth2 from bridge br1"
ip link set br1-eth2 nomaster
echo "\n"
echo "Bring bridge br0 down"
ip link set br0 down
echo "\n"
echo "Delete bridge br0"
ip link delete br0 type bridge
echo "\n"
echo "Bring bridge br1 down"
ip link set br1 down
echo "\n"
echo "Delete bridge br1"
ip link delete br1 type bridge
echo "\n"
echo "Delete virtual Ethernet cable br0-eth1 <---------------> br1-eth1"
ip link del br0-eth1 type veth peer name br1-eth1
echo "\n"
echo "Delete virtual Ethernet cable br0-eth2 <---------------> br1-eth2"
ip link del br0-eth2 type veth peer name br1-eth2
echo "\n"
sleep 5
echo "Check ip links"
ip link
echo "\n"
