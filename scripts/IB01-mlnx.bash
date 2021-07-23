echo "OS.EnableRDMA=y" >> /etc/waagent.conf
echo "vm.zone_reclaim_mode = 1" >> /etc/sysctl.conf sysctl -p

cat << EOF > /etc/security/limits.d/99-alcesinfiniband.conf
#RDMA needs to work with pinned memory, i.e. memory which cannot be swapped out by the kernel.
#By default, every process that is running as a non-root user is allowed to pin a low amount of memory (64KB).
#In order to work properly as a non-root user, it is highly recommended to increase the size of memory which
#can be locked
* soft memlock unlimited
* hard memlock unlimited
EOF

curl http://10.110.1.200/deployment/files/OFED.tgz > /tmp/ofed.tgz
cd /tmp
tar -xzvf ofed.tgz
KERNEL=( $(rpm -q kernel | sed 's/kernel\-//g') )
KERNEL=${KERNEL[-1]}
mlnx=`ls -d MLNX_OFED*`
yum install -y kernel-devel-${KERNEL} python-devel tk

cd $mlnx
./mlnxofedinstall --kernel $KERNEL --kernel-sources /usr/src/kernels/${KERNEL} --add-kernel-support --skip-repo --skip-distro-check

dracut -f

IP=10.112.`ip route get 1 | awk '{print $NF;exit}' | cut -d '.' -f3,4`

cat << EOF > /etc/sysconfig/network-scripts/ifcfg-ib0
TYPE=Infiniband
BOOTPROTO=none
DEFROUTE=yes
PEERDNS=no
PEERROUTES=no
IPV4_FAILURE_FATAL=no
IPV6INIT=no
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_PEERDNS=yes
IPV6_PEERROUTES=yes
IPV6_FAILURE_FATAL=no
NAME=ib0
DEVICE=ib0
ONBOOT=yes
IPADDR=$IP
NETMASK=255.255.0.0
ZONE=trusted
LINKDELAY=60
EOF
