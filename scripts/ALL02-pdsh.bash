#yum -y install epel-release

cat << EOF > /etc/genders
chead1    headnode,compute,all
cadmin01    admin,site,all
cnode[01-10] gpu,nodes,compute,all
EOF

mkdir /root/.ssh
echo "StrictHostKeyChecking no" >> /root/.ssh/config

yum -y install pdsh pdsh-mod-genders
