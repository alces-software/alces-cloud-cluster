yum -y install nfs-utils
cat << EOF >> /etc/fstab
10.110.1.11:/export/users    /users    nfs    intr,_netdev,vers=3    0 0
10.110.1.11:/export/apps    /opt/apps    nfs    intr,_netdev,vers=3    0 0
10.110.1.11:/export/gridware    /opt/gridware    nfs    intr,_netdev,vers=3    0 0
10.110.1.11:/export/service    /opt/service    nfs    intr,_netdev,vers=3    0 0
10.110.1.11:/export/site	/opt/site	nfs    intr,_netdev,vers=3    0 0
EOF
mkdir -p /users
mkdir -p /opt/apps
mkdir -p /opt/gridware
mkdir -p /opt/service
mkdir -p /opt/site

mount -t nfs -a
