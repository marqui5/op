###vlan
<Huawei>display vlan
<Huawei>system-view
<Huawei>sys
Enter system view, return user view with Ctrl+Z.
[Huawei]vlan batch 2 to 3
Info: This operation may take a few seconds. Please wait for a moment...done.
[Huawei]
Nov 30 2019 16:23:55-08:00 Huawei DS/4/DATASYNC_CFGCHANGE:OID 1.3.6.1.4.1.2011.5
.25.191.3.1 configurations have been changed. The current change number is 4, th
e change loop count is 0, and the maximum number of records is 4095.
[Huawei]vlan 5
[Huawei]quit
[Huawei]undo info-center enable
[Huawei]un in en
Info: Information center is disabled.
[Huawei]display vlan
The total number of vlans is : 4
--------------------------------------------------------------------------------
U: Up;         D: Down;         TG: Tagged;         UT: Untagged;
MP: Vlan-mapping;               ST: Vlan-stacking;
#: ProtocolTransparent-vlan;    *: Management-vlan;
--------------------------------------------------------------------------------

VID  Type    Ports                                                          
--------------------------------------------------------------------------------
1    common  UT:GE0/0/1(D)      GE0/0/2(D)      GE0/0/3(D)      GE0/0/4(D)      
                GE0/0/5(D)      GE0/0/6(D)      GE0/0/7(D)      GE0/0/8(D)      
                GE0/0/9(D)      GE0/0/10(D)     GE0/0/11(D)     GE0/0/12(D)     
                GE0/0/13(D)     GE0/0/14(D)     GE0/0/15(D)     GE0/0/16(D)     
                GE0/0/17(D)     GE0/0/18(D)     GE0/0/19(D)     GE0/0/20(D)     
                GE0/0/21(D)     GE0/0/22(D)     GE0/0/23(D)     GE0/0/24(D)     

2    common  
3    common  
5    common  

VID  Status  Property      MAC-LRN Statistics Description      
--------------------------------------------------------------------------------

1    enable  default       enable  disable    VLAN 0001                         
2    enable  default       enable  disable    VLAN 0002                         
3    enable  default       enable  disable    VLAN 0003                         
5    enable  default       enable  disable    VLAN 0005*

[Huawei]interface g0/0/2
[Huawei-GigabitEthernet0/0/2]
[Huawei-GigabitEthernet0/0/2]port link-type ?
  access        Access port
  dot1q-tunnel  QinQ port
  hybrid        Hybrid port
  trunk         Trunk port
[Huawei-GigabitEthernet0/0/2]port link-type access
[Huawei-GigabitEthernet0/0/2]port default vlan 2
[Huawei-GigabitEthernet0/0/2]display this
#
interface GigabitEthernet0/0/2
 port link-type access
 port default vlan 2
#
return
[Huawei]clear configuration interface g0/0/2
Warning: All configurations of the interface will be cleared, and its state will
 be shutdown. Continue? [Y/N] :Y
Info: Total execute 2 command(s), 2 successful, 0 failed.
[Huawei]interface g0/0/2
[Huawei-GigabitEthernet0/0/2]undo shutdown
[Huawei]interface g0/0/1
[Huawei-GigabitEthernet0/0/1]port link-type trunk
[Huawei-GigabitEthernet0/0/1]port trunk allow-pass vlan 2
[Huawei-GigabitEthernet0/0/1]display this
#
interface GigabitEthernet0/0/1
 port link-type trunk
 port trunk allow-pass vlan 2
#
return
[Huawei]undo vlan 2
[Huawei]undo vlan batch 3 to 5
[Huawei]sysname SLW1
[Huawei]sys LSW1
[SLW1]quit
<SLW1>save
###Trunk
[LSW1]vlan 2
[LSW1]interface GigabitEthernet 0/0/3
[LSW1-GigabitEthernet0/0/3]port link-type access
[LSW1-GigabitEthernet0/0/3]port default vlan 2  
[LSW1]interface GigabitEthernet 0/0/1
[LSW1-GigabitEthernet0/0/1]port link-type trunk
[LSW1-GigabitEthernet0/0/1]port trunk allow-pass vlan all
[LSW2]vlan 2
[LSW2-GigabitEthernet0/0/3]port link-type access
[LSW2-GigabitEthernet0/0/3]port default vlan 2
[LSW2]interface GigabitEthernet 0/0/1
[LSW2-GigabitEthernet0/0/1]port link-type trunk
[LSW2-GigabitEthernet0/0/1]port trunk allow-pass vlan all
###Hybrid
[LSW1]vlan 2
[LSW1]interface GigabitEthernet 0/0/3
[LSW1-GigabitEthernet0/0/3]port hybrid pvid vlan 2
[LSW1-GigabitEthernet0/0/3]port hybrid untagged vlan 2  
[LSW1]interface GigabitEthernet 0/0/1
[LSW1-GigabitEthernet0/0/1]port hybrid tagged vlan 2
[LSW2]vlan 2
[LSW2-GigabitEthernet0/0/3]port hybrid pvid vlan 2
[LSW2-GigabitEthernet0/0/3]port hybrid untagged vlan 2
[LSW2]interface GigabitEthernet 0/0/1
[LSW2-GigabitEthernet0/0/1]port hybrid tagged vlan 1 2
###Router on a stick
[LSW1]vlan batch 2 3
[LSW1]interface g0/0/1
[LSW1-GigabitEthernet0/0/1]port link-type trunk
[LSW1-GigabitEthernet0/0/1]port trunk allow-pass vlan 2 3
[LSW1]interface GigabitEthernet 0/0/2
[LSW1-GigabitEthernet0/0/2]port link-type access
[LSW1-GigabitEthernet0/0/2]port default vlan 2  
[LSW1]interface GigabitEthernet 0/0/3
[LSW1-GigabitEthernet0/0/3]port link-type access
[LSW1-GigabitEthernet0/0/3]port default vlan 3
[R1]interface e0/0/0.1
[R1-Ethernet0/0/0.1]dot1q termination vid 2
[R1-Ethernet0/0/0.1]ip address 192.168.1.1 24
[R1-Ethernet0/0/0.1]arp broadcast enable
[R1]interface e0/0/0.2
[R1-Ethernet0/0/0.2]dot1q termination vid 3
[R1-Ethernet0/0/0.2]ip address 192.168.2.1 24
[R1-Ethernet0/0/0.2]arp broadcast enable
PC1:
IPv4 address......................: 192.168.1.2
Subnet mask.......................: 255.255.255.0
Gateway...........................: 192.168.1.1
PC2:
IPv4 address......................: 192.168.2.2
Subnet mask.......................: 255.255.255.0
Gateway...........................: 192.168.2.1
###Vlanif
[LSW1]vlan batch 2 3
[LSW1]interface g0/0/1
[LSW1-GigabitEthernet0/0/1]port link-type trunk
[LSW1-GigabitEthernet0/0/1]port trunk allow-pass vlan 2 3
[LSW1]interface GigabitEthernet 0/0/2
[LSW1-GigabitEthernet0/0/2]port link-type access
[LSW1-GigabitEthernet0/0/2]port default vlan 2  
[LSW1]interface GigabitEthernet 0/0/3
[LSW1-GigabitEthernet0/0/3]port link-type access
[LSW1-GigabitEthernet0/0/3]port default vlan 3
[LSW1]interface vlanif 2
[LSW1-Vlanif2]ip address 192.168.1.1 24
[LSW1]interface vlanif 3
[LSW1-Vlanif2]ip address 192.168.2.1 24
PC1:
IPv4 address......................: 192.168.1.2
Subnet mask.......................: 255.255.255.0
Gateway...........................: 192.168.1.1
PC2:
IPv4 address......................: 192.168.2.2
Subnet mask.......................: 255.255.255.0
Gateway...........................: 192.168.2.1

###Enterprise
##Vlan
<Huawei>sys
Enter system view, return user view with Ctrl+Z.
[LSW1]un in en
Info: Information center is disabled.
[Huawei]sys LSW1
[LSW1]vlan 10
[LSW1-vlan10]vlan 20
[LSW1-vlan20]quit
[LSW1]int e0/0/1
[LSW1-Ethernet0/0/1]un sh
Info: Interface Ethernet0/0/1 is not shutdown.
[LSW1-Ethernet0/0/1]port link-t a
[LSW1-Ethernet0/0/1]port de vlan 10
[LSW1-Ethernet0/0/1]int e0/0/2
[LSW1-Ethernet0/0/2]port link-t a
[LSW1-Ethernet0/0/2]port de vlan 20
[LSW1-Ethernet0/0/2]int e0/0/3
[LSW1-Ethernet0/0/3]port link-t t
[LSW1-Ethernet0/0/3]port t allow vlan all
[LSW1-Ethernet0/0/3]int e0/0/4
[LSW1-Ethernet0/0/4]port link-t t
[LSW1-Ethernet0/0/4]port t allow vlan all
[LSW1-Ethernet0/0/4]quit
[LSW1]quit
<LSW1>save

[LSW2]vlan 30
[LSW2-vlan30]vlan 40
[LSW2-vlan40]in e0/0/1
[LSW2-Ethernet0/0/1]port link-t a
[LSW2-Ethernet0/0/1]port de vlan 30
[LSW2-Ethernet0/0/1]int e0/0/2
[LSW2-Ethernet0/0/2]port link-t a
[LSW2-Ethernet0/0/2]port de vlan 40
[LSW2-Ethernet0/0/2]in e0/0/3
[LSW2-Ethernet0/0/3]port link-t t
[LSW2-Ethernet0/0/3]port t allow vlan all
[LSW2-Ethernet0/0/3]in e0/0/4
[LSW2-Ethernet0/0/4]port link-t t
[LSW2-Ethernet0/0/4]port t allow vlan all
[LSW2-Ethernet0/0/4]quit
[LSW2]quit
<LSW2>save

[LSW3]vlan 10
[LSW3-vlan10]vlan 20
[LSW3-vlan20]vlan 30
[LSW3-vlan30]vlan 40
[LSW3-vlan40]vlan 50
[LSW3-vlan50]vlan 60
[LSW3-vlan60]in g0/0/1
[LSW3-GigabitEthernet0/0/1]port link-t t
[LSW3-GigabitEthernet0/0/1]port t allow vlan all
[LSW3-GigabitEthernet0/0/1]in g0/0/2
[LSW3-GigabitEthernet0/0/2]port link-t t
[LSW3-GigabitEthernet0/0/2]port t allow vlan all
[LSW3-GigabitEthernet0/0/2]in g0/0/3
[LSW3-GigabitEthernet0/0/3]port link-t t
[LSW3-GigabitEthernet0/0/3]port t allow vlan all
[LSW3-GigabitEthernet0/0/3]in g0/0/4
[LSW3-GigabitEthernet0/0/4]port link-t a
[LSW3-GigabitEthernet0/0/4]port de vlan 60
[LSW3-GigabitEthernet0/0/4]int g0/0/5
[LSW3-GigabitEthernet0/0/5]port link-t a
[LSW3-GigabitEthernet0/0/5]port de vlan 50
[LSW3-GigabitEthernet0/0/5]quit
[LSW3]int vlan 10
[LSW3-Vlanif10]ip address 192.168.10.1 255.255.255.0
[LSW3-Vlanif10]int vlan 20
[LSW3-Vlanif20]ip add 192.168.20.1 24
[LSW3-Vlanif20]int vlan 30
[LSW3-Vlanif30]ip add 192.168.30.1 24
[LSW3-Vlanif30]int vlan 40
[LSW3-Vlanif40]ip add 192.168.40.1 24
[LSW3-Vlanif40]int vlan 50
[LSW3-Vlanif50]ip add 192.168.50.1 24
[LSW3-Vlanif50]int vlan 60
[LSW3-Vlanif60]ip add 192.168.60.1 24
[LSW3-Vlanif60]quit

[LSW4]vlan 10
[LSW4-vlan10]vlan 20
[LSW4-vlan20]vlan 30
[LSW4-vlan30]vlan 40
[LSW4-vlan40]vlan 50
[LSW4-vlan50]vlan 60
[LSW4-vlan60]vlan 70
[LSW4-vlan70]int g0/0/1
[LSW4-GigabitEthernet0/0/1]port link-t t
[LSW4-GigabitEthernet0/0/1]port t allow vlan all
[LSW4-GigabitEthernet0/0/1]int g0/0/2
[LSW4-GigabitEthernet0/0/2]port link-t t
[LSW4-GigabitEthernet0/0/2]port t allow vlan all
[LSW4-GigabitEthernet0/0/2]int g0/0/3
[LSW4-GigabitEthernet0/0/3]port link-t t
[LSW4-GigabitEthernet0/0/3]port t allow vlan all
[LSW4-GigabitEthernet0/0/3]int g0/0/4
[LSW4-GigabitEthernet0/0/4]port link-t a
[LSW4-GigabitEthernet0/0/4]port de vlan 70
[LSW4-GigabitEthernet0/0/4]quit
[LSW4]int vlan 10
[LSW4-Vlanif10]ip add 192.168.10.2 24
[LSW4-Vlanif10]int vlan 20
[LSW4-Vlanif20]ip add 192.168.20.2 24
[LSW4-Vlanif20]int vlan 30
[LSW4-Vlanif30]ip add 192.168.30.2 24
[LSW4-Vlanif30]int vlan 40
[LSW4-Vlanif40]ip add 192.168.40.2 24
[LSW4-Vlanif40]int vlan 70
[LSW4-Vlanif70]ip add 192.168.70.2 24
[LSW4-Vlanif70]quit

##DHCP
[LSW3]dhcp en
Info: The operation may take a few seconds. Please wait for a moment.done.
[LSW3]ip pool vlan10
Info:It's successful to create an IP address pool.
[LSW3-ip-pool-vlan10]gateway-list 192.168.10.254
[LSW3-ip-pool-vlan10]network 192.168.10.0 mask 255.255.255.0
[LSW3-ip-pool-vlan10]excluded-ip-address 192.168.10.1 192.168.10.127
[LSW3-ip-pool-vlan10]int vlan 10
[LSW3-Vlanif10]dhcp select global
[LSW3-Vlanif10]ip pool vlan20
Info:It's successful to create an IP address pool.
[LSW3-ip-pool-vlan20]gateway-list 192.168.20.254
[LSW3-ip-pool-vlan20]network 192.168.20.0 mask 255.255.255.0
[LSW3-ip-pool-vlan20]excluded-ip-address 192.168.20.1 192.168.20.127
[LSW3-ip-pool-vlan20]int vlan 20
[LSW3-Vlanif20]dhcp select global
[LSW3-Vlanif20]ip pool vlan30
Info:It's successful to create an IP address pool.
[LSW3-ip-pool-vlan30]gateway-list 192.168.30.254
[LSW3-ip-pool-vlan30]network 192.168.30.0 mask 255.255.255.0
[LSW3-ip-pool-vlan30]excluded-ip-address 192.168.30.1 192.168.30.127
[LSW3-ip-pool-vlan30]int vlan 30
[LSW3-Vlanif30]dhcp select global
[LSW3-Vlanif30]ip pool vlan40
Info:It's successful to create an IP address pool.
[LSW3-ip-pool-vlan40]gateway-list 192.168.40.254
[LSW3-ip-pool-vlan40]network 192.168.40.0 mask 255.255.255.0
[LSW3-ip-pool-vlan40]excluded-ip-address 192.168.40.1 192.168.40.127
[LSW3-ip-pool-vlan40]int vlan 40
[LSW3-Vlanif40]dhcp select global
[LSW3-Vlanif40]quit
[LSW3]quit
<LSW3>save

[LSW4]dhcp en
Info: The operation may take a few seconds. Please wait for a moment.done.
[LSW4]ip pool vlan10
Info:It's successful to create an IP address pool.
[LSW4-ip-pool-vlan10]gateway-list 192.168.10.254
[LSW4-ip-pool-vlan10]network 192.168.10.0 mask 255.255.255.0
[LSW4-ip-pool-vlan10]ex 192.168.10.128 192.168.10.253
[LSW4-ip-pool-vlan10]int vlan 10
[LSW4-Vlanif10]dhcp select global
[LSW4-Vlanif10]ip pool vlan20
Info:It's successful to create an IP address pool.
[LSW4-ip-pool-vlan20]gateway-list 192.168.20.254
[LSW4-ip-pool-vlan20]network 192.168.20.0 mask 255.255.255.0
[LSW4-ip-pool-vlan20]ex 192.168.20.128 192.168.20.253
[LSW4-ip-pool-vlan20]int vlan 20
[LSW4-Vlanif20]dhcp select global
[LSW4-Vlanif20]ip pool vlan30
Info:It's successful to create an IP address pool.
[LSW4-ip-pool-vlan30]gateway-list 192.168.30.254
[LSW4-ip-pool-vlan30]network 192.168.30.0 mask 255.255.255.0
[LSW4-ip-pool-vlan30]ex 192.168.30.128 192.168.30.253
[LSW4-ip-pool-vlan30]int vlan 30
[LSW4-Vlanif30]dhcp select global
[LSW4-Vlanif30]ip pool vlan40
Info:It's successful to create an IP address pool.
[LSW4-ip-pool-vlan40]gateway-list 192.168.40.254
[LSW4-ip-pool-vlan40]network 192.168.40.0 mask 255.255.255.0
[LSW4-ip-pool-vlan40]ex 192.168.40.128 192.168.40.253
[LSW4-ip-pool-vlan40]int vlan 40
[LSW4-Vlanif40]dhcp select global
[LSW4-Vlanif40]quit
[LSW4]quit
<LSW4>save

##STP+VRRP
#STP
[LSW1]stp mode stp
Info: This operation may take a few seconds. Please wait for a moment...done.
[LSW1]quit
<LSW1>save
[LSW2]stp m stp
Info: This operation may take a few seconds. Please wait for a moment...done.
[LSW2]quit
<LSW2>save
[LSW3]stp m stp
Info: This operation may take a few seconds. Please wait for a moment...done.
[LSW3]stp priorit
[LSW3]stp priority 0
[LSW4]stp m stp
Info: This operation may take a few seconds. Please wait for a moment...done.
[LSW4]stp prio 4096
#VRRP
[LSW3]int vlan 10
[LSW3-Vlanif10]vrrp vrid 10 vi 192.168.10.254
[LSW3-Vlanif10]vrrp vrid 10 prio 120
[LSW3-Vlanif10]vrrp vrid 10 track int g0/0/4 reduced 30
[LSW3-Vlanif10]int vlan 20
[LSW3-Vlanif20]vrrp vrid 20 vi 192.168.20.254
[LSW3-Vlanif20]vrrp vrid 20 prio 120
[LSW3-Vlanif20]vrrp vrid 20 track int g0/0/4 re 30
[LSW3-Vlanif20]int vlan 30
[LSW3-Vlanif30]vrrp vrid 30 vi 192.168.30.254
[LSW3-Vlanif30]int vlan 40
[LSW3-Vlanif40]vrrp vrid 40 vi 192.168.40.254
[LSW3-Vlanif40]quit

[LSW4]int vlan 10
[LSW4-Vlanif10]vrrp vrid 10 vi 192.168.10.254
[LSW4-Vlanif10]int vlan 20
[LSW4-Vlanif20]vrrp vrid 20 vi 192.168.20.254
[LSW4-Vlanif20]int vlan 30
[LSW4-Vlanif30]vrrp vrid 30 vi 192.168.30.254
[LSW4-Vlanif30]vrrp vrid 30 prio 120
[LSW4-Vlanif30]vrrp vrid 30 track int g0/0/4 re 30
[LSW4-Vlanif30]int vlan 40
[LSW4-Vlanif40]vrrp vrid 40 prio 120
Error: The VRRP does not exist.
[LSW4-Vlanif40]vrrp vrid 40 vi 192.168.40.254
[LSW4-Vlanif40]vrrp vrid 40 prio 120
[LSW4-Vlanif40]vrrp vrid 40 track int g0/0/4 re 30
[LSW4-Vlanif40]quit

##OSPF
[LSW3]dis ip int br
down: administratively down
^down: standby
(l): loopback
(s): spoofing
The number of interface that is UP in Physical is 8
The number of interface that is DOWN in Physical is 1
The number of interface that is UP in Protocol is 7
The number of interface that is DOWN in Protocol is 2

Interface                         IP Address/Mask      Physical   Protocol  
MEth0/0/1                         unassigned           down       down      
NULL0                             unassigned           up         up(s)     
Vlanif1                           unassigned           up         down      
Vlanif10                          192.168.10.1/24      up         up        
Vlanif20                          192.168.20.1/24      up         up        
Vlanif30                          192.168.30.1/24      up         up        
Vlanif40                          192.168.40.1/24      up         up        
Vlanif50                          192.168.50.1/24      up         up        
Vlanif60                          192.168.60.1/24      up         up
[LSW3]ospf 1
[LSW3-ospf-1]area 0.0.0.0
[LSW3-ospf-1-area-0.0.0.0]net 192.168.10.0 0.0.0.255
[LSW3-ospf-1-area-0.0.0.0]net 192.168.20.0 0.0.0.255
[LSW3-ospf-1-area-0.0.0.0]net 192.168.30.0 0.0.0.255
[LSW3-ospf-1-area-0.0.0.0]net 192.168.40.0 0.0.0.255
[LSW3-ospf-1-area-0.0.0.0]net 192.168.50.0 0.0.0.255
[LSW3-ospf-1-area-0.0.0.0]net 192.168.60.0 0.0.0.255
[LSW3-ospf-1-area-0.0.0.0]quit

[LSW4]dis ip int br
down: administratively down
^down: standby
(l): loopback
(s): spoofing
The number of interface that is UP in Physical is 7
The number of interface that is DOWN in Physical is 1
The number of interface that is UP in Protocol is 6
The number of interface that is DOWN in Protocol is 2

Interface                         IP Address/Mask      Physical   Protocol  
MEth0/0/1                         unassigned           down       down      
NULL0                             unassigned           up         up(s)     
Vlanif1                           unassigned           up         down      
Vlanif10                          192.168.10.2/24      up         up        
Vlanif20                          192.168.20.2/24      up         up        
Vlanif30                          192.168.30.2/24      up         up        
Vlanif40                          192.168.40.2/24      up         up        
Vlanif70                          192.168.70.2/24      up         up        
[LSW4]ospf 1
[LSW4-ospf-1]area 0.0.0.0
[LSW4-ospf-1-area-0.0.0.0]net 192.168.10.0 0.0.0.255
[LSW4-ospf-1-area-0.0.0.0]net 192.168.20.0 0.0.0.255
[LSW4-ospf-1-area-0.0.0.0]net 192.168.30.0 0.0.0.255
[LSW4-ospf-1-area-0.0.0.0]net 192.168.40.0 0.0.0.255
[LSW4-ospf-1-area-0.0.0.0]net 192.168.70.0 0.0.0.255
[LSW4-ospf-1-area-0.0.0.0]quit

<Huawei>sys
Enter system view, return user view with Ctrl+Z.
[Huawei]un in en
Info: Information center is disabled.
[Huawei]sys AR1
[AR1]int g0/0/0
[AR1-GigabitEthernet0/0/0]ip add 192.168.60.100 24
[AR1-GigabitEthernet0/0/0]int g0/0/1
[AR1-GigabitEthernet0/0/1]ip add 192.168.70.100 24
[AR1-GigabitEthernet0/0/1]int g0/0/2
[AR1-GigabitEthernet0/0/2]ip add 200.200.200.1 24
[AR1-GigabitEthernet0/0/2]quit
[AR1]dis ip int br
down: administratively down
^down: standby
(l): loopback
(s): spoofing
The number of interface that is UP in Physical is 4
The number of interface that is DOWN in Physical is 0
The number of interface that is UP in Protocol is 4
The number of interface that is DOWN in Protocol is 0

Interface                         IP Address/Mask      Physical   Protocol  
GigabitEthernet0/0/0              192.168.60.100/24    up         up        
GigabitEthernet0/0/1              192.168.70.100/24    up         up        
GigabitEthernet0/0/2              200.200.200.1/24     up         up        
NULL0                             unassigned           up         up(s)     
[AR1]ospf 1
[AR1-ospf-1]area 0.0.0.0
[AR1-ospf-1-area-0.0.0.0]net 192.168.60.0 0.0.0.255
[AR1-ospf-1-area-0.0.0.0]net 192.168.70.0 0.0.0.255
[AR1-ospf-1-area-0.0.0.0]net 200.200.200.0 0.0.0.255
[AR1-ospf-1-area-0.0.0.0]quit
[AR1-ospf-1]quit
[AR1]ip route-static 0.0.0.0 0.0.0.0 200.200.200.100
[AR1]ospf 1
[AR1-ospf-1]default-route-advertise
[AR1-ospf-1]quit
[AR1]quit
<AR1>save

<Huawei>sys
Enter system view, return user view with Ctrl+Z.
[Huawei]un in en
Info: Information center is disabled.
[Huawei]sys AR2
[AR2]int g0/0/0
[AR2-GigabitEthernet0/0/0]ip add 200.200.200.100 24
[AR2-GigabitEthernet0/0/0]int g0/0/1
[AR2-GigabitEthernet0/0/1]ip add 200.200.201.1 24
[AR2-GigabitEthernet0/0/1]quit
[AR2]quit
<AR2>save

##ACL+NAT
[AR1]acl number 2000
[AR1-acl-basic-2000]rule 0 permit source 192.168.10.0 0.0.0.255
[AR1-acl-basic-2000]rule 5 permit source 192.168.30.0 0.0.0.255
[AR1-acl-basic-2000]rule 10 permit source 192.168.50.0 0.0.0.255
[AR1-acl-basic-2000]quit
[AR1]int g0/0/2
[AR1-GigabitEthernet0/0/2]nat outbound 2000
[AR1-GigabitEthernet0/0/2]nat static global 200.200.200.10 inside 192.168.50.100
[AR1-GigabitEthernet0/0/2]quit
[AR1]quit
<AR1>save

##single point of failure simulate
[LSW3]dis vrrp br
VRID  State        Interface                Type     Virtual IP     
----------------------------------------------------------------
10    Master       Vlanif10                 Normal   192.168.10.254
20    Master       Vlanif20                 Normal   192.168.20.254
30    Backup       Vlanif30                 Normal   192.168.30.254
40    Backup       Vlanif40                 Normal   192.168.40.254
----------------------------------------------------------------
Total:4     Master:2     Backup:2     Non-active:0

[LSW4]dis vrrp br
VRID  State        Interface                Type     Virtual IP     
----------------------------------------------------------------
10    Backup       Vlanif10                 Normal   192.168.10.254
20    Backup       Vlanif20                 Normal   192.168.20.254
30    Master       Vlanif30                 Normal   192.168.30.254
40    Master       Vlanif40                 Normal   192.168.40.254
----------------------------------------------------------------
Total:4     Master:2     Backup:2     Non-active:0     
[LSW4]int g0/0/4
[LSW4-GigabitEthernet0/0/4]sh
[LSW4-GigabitEthernet0/0/4]dis vrrp br
VRID  State        Interface                Type     Virtual IP     
----------------------------------------------------------------
10    Backup       Vlanif10                 Normal   192.168.10.254
20    Backup       Vlanif20                 Normal   192.168.20.254
30    Backup       Vlanif30                 Normal   192.168.30.254
40    Backup       Vlanif40                 Normal   192.168.40.254
----------------------------------------------------------------
Total:4     Master:0     Backup:4     Non-active:0     

[LSW3]dis vrrp br
VRID  State        Interface                Type     Virtual IP     
----------------------------------------------------------------
10    Master       Vlanif10                 Normal   192.168.10.254
20    Master       Vlanif20                 Normal   192.168.20.254
30    Backup       Vlanif30                 Normal   192.168.30.254
40    Backup       Vlanif40                 Normal   192.168.40.254
----------------------------------------------------------------
Total:4     Master:2     Backup:2     Non-active:0     
[LSW3]dis vrrp br
VRID  State        Interface                Type     Virtual IP     
----------------------------------------------------------------
10    Master       Vlanif10                 Normal   192.168.10.254
20    Master       Vlanif20                 Normal   192.168.20.254
30    Master       Vlanif30                 Normal   192.168.30.254
40    Master       Vlanif40                 Normal   192.168.40.254
----------------------------------------------------------------
Total:4     Master:4     Backup:0     Non-active:0     
##Recovery
[LSW4-GigabitEthernet0/0/4]un sh    
[LSW4-GigabitEthernet0/0/4]dis vrrp br
VRID  State        Interface                Type     Virtual IP     
----------------------------------------------------------------
10    Backup       Vlanif10                 Normal   192.168.10.254
20    Backup       Vlanif20                 Normal   192.168.20.254
30    Master       Vlanif30                 Normal   192.168.30.254
40    Master       Vlanif40                 Normal   192.168.40.254
----------------------------------------------------------------
Total:4     Master:2     Backup:2     Non-active:0     
[LSW4-GigabitEthernet0/0/4]
