DISK=/dev/disk/azure/scsi1/lun0 # Azure specific
PART=${DISK}-part1 # Azure specific

if [ -b $DISK ]; then
  parted $DISK --script mklabel gpt
  parted -a optimal ${DISK} --script mkpart primary ext4 0% 100%
  mkfs.xfs ${PART} -L export
  cat << EOF >> /etc/fstab
LABEL=export	/export/	xfs	defaults,nofail	0 2
EOF
  mkdir /export
  mount /export
fi

yum -y install nfs-utils
sed -ie "s/^#\RPCNFSDCOUNT.*$/\RPCNFSDCOUNT=32/g" /etc/sysconfig/nfs

mkdir -p /export/users
mkdir -p /export/service
mkdir -p /export/gridware
mkdir -p /export/apps
mkdir -p /export/site

cat << EOF > /etc/exports 
/export/users 10.110.1.0/24(rw,no_root_squash,no_subtree_check,sync)
/export/service 10.110.1.0/24(rw,no_root_squash,no_subtree_check,sync)
/export/gridware 10.110.1.0/24(rw,no_root_squash,no_subtree_check,sync)
/export/apps 10.110.1.0/24(rw,no_root_squash,no_subtree_check,sync)
/export/site 10.110.1.0/24(rw,no_root_squash,no_subtree_check,sync)
EOF

cat << EOF >> /etc/fstab

/export/users    /users    none    defaults,bind,nofail 0 2
/export/site     /opt/site    none    defaults,bind,nofail 0 2
/export/gridware    /opt/gridware    none    defaults,bind,nofail 0 2
/export/service        /opt/service    none    defaults,bind,nofail 0 2
/export/apps        /opt/apps    none    defaults,bind,nofail 0 2
EOF


mkdir /users
mkdir /opt/site
mkdir /opt/gridware
mkdir /opt/apps
mkdir /opt/service

systemctl enable nfs
systemctl restart nfs
