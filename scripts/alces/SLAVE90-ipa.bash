DOMAIN=`hostname -d`
REALM=PRI.CLUSTERNAME.ALCES.NETWORK
SERVER=infra01.pri.clustername.alces.network

PASSWORD=IPAPASS

echo "10.10.0.51	${SERVER}" >> /etc/hosts

yum -y install ipa-client
ipa-client-install --no-ntp --mkhomedir --no-ssh --no-sshd --force-join --realm="$REALM" --server="${SERVER}" -w "${PASSWORD}" --domain="${DOMAIN}" --unattended --hostname="`hostname -f`"

cat << EOF > /etc/resolv.conf
search cloud1.pri.clustername.alces.network pri.clustername.alces.network mgt.clustername.alces.network ib.clustername.alces.network bmc.mgt.clustername.alces.network clustername.alces.network
nameserver 10.10.0.51
EOF
