#!/bin/bash

# Variables
HNAME=`hostname -f`
DOMAIN=`hostname -d`
REALM=${DOMAIN^^}
IP=`ip route get 1 | awk '{print $NF;exit}'`
DNS_REV=`echo ${IP} | awk 'BEGIN {FS="."}; {print $2"."$1}'`

# Install packages
yum -y install ipa-server bind bind-dyndb-ldap ipa-server-dns

echo -n "Secure Admin Password:"
read PASSWORD

# Server setup
ipa-server-install -a "${PASSWORD}" --hostname "${HNAME}" --ip-address="${IP}" -r "$REALM" -p "${PASSWORD}" -n "${DOMAIN}" --no-ntp --setup-dns --forwarder="10.110.1.200" --reverse-zone="${DNS_REV}.in-addr.arpa." --ssh-trust-dns --unattended --mkhomedir --no-ssh --no-sshd

# Auth
kinit admin

# Add controller DNS entry
ipa dnsrecord-add ${DOMAIN} cgw1 --a-ip-address=10.110.1.200
ipa dnsrecord-add ${DNS_REV}.in-addr.arpa. 254.1 --ptr-hostname cgw1.{$DOMAIN}}

# Add mail entry
ipa dnsrecord-add ${DOMAIN} @ --mx-preference=0 --mx-exchanger=cgw1

# Add user config (home dir, shell, groups)
ipa config-mod --defaultshell /bin/bash
ipa config-mod --homedirectory /users
ipa group-add ClusterUsers --desc="Generic Cluster Users"
ipa group-add AdminUsers --desc="Admin Cluster Users"
ipa config-mod --defaultgroup ClusterUsers
ipa pwpolicy-mod --maxlife=999

# Host groups
ipa hostgroup-add usernodes --desc "All nodes allowing standard user access"
ipa hostgroup-add adminnodes --desc "All nodes allowing only admin user access"

# Add alces user
ipa user-add alces-cluster --first Alces --last Software --random
ipa group-add-member AdminUsers --users alces-cluster
echo "ALCES USER PASSWORD"
ipa user-mod alces-cluster --password # Sets user password through prompts

# Access rules
ipa hbacrule-disable allow_all
ipa hbacrule-add siteaccess --desc "Allow admin access to admin hosts"
ipa hbacrule-add useraccess --desc "Allow user access to user hosts"
ipa hbacrule-add-service siteaccess --hbacsvcs sshd
ipa hbacrule-add-service useraccess --hbacsvcs sshd
ipa hbacrule-add-user siteaccess --groups AdminUsers
ipa hbacrule-add-user useraccess --groups ClusterUsers
ipa hbacrule-add-host siteaccess --hostgroups adminnodes
ipa hbacrule-add-host useraccess --hostgroups usernodes

# Sudo rules
ipa sudorule-add --cmdcat=all All
ipa sudorule-add-user --groups=adminusers All
ipa sudorule-mod All --hostcat='all'
ipa sudorule-add-option All --sudooption '!authenticate'

#Site stuff
ipa user-add siteadmin --first Site --last Admin --random
ipa group-add siteadmins --desc="Site admin users (power users)"
ipa hostgroup-add sitenodes --desc "All nodes allowing site admin access"
ipa group-add-member siteadmins --users siteadmin
echo "SITE ADMIN USER PASSWORD"
ipa user-mod siteadmin --password # Sets user password through prompts
ipa hbacrule-add-user siteaccess --groups siteadmins
ipa hbacrule-add-host siteaccess --hostgroups sitenodes
ipa hbacrule-add-service useraccess --hbacsvcgroups=Sudo
ipa hbacrule-add-service siteaccess --hbacsvcgroups=Sudo

ipa sudorule-add --cmdcat=all Site
ipa sudorule-add-user --groups=siteadmins Site
ipa sudorule-mod Site --hostcat=''
ipa sudorule-add-option Site --sudooption '!authenticate'
ipa sudorule-add-host Site --hostgroups=sitenodes

# Update name resolution
grep search /etc/resolv.conf > /etc/resolv.conf.new
mv -f /etc/resolv.conf.new /etc/resolv.conf

cat << EOF >> /etc/resolv.conf
nameserver ${IP}
EOF

ipa host-add cnode01.${DOMAIN} --ip-address=10.110.1.101 --password='IPAPASS'
ipa host-add cnode02.${DOMAIN} --ip-address=10.110.1.102 --password='IPAPASS'
ipa host-add cnode03.${DOMAIN} --ip-address=10.110.1.103 --password='IPAPASS'
ipa host-add cnode04.${DOMAIN} --ip-address=10.110.1.104 --password='IPAPASS'
ipa host-add cnode05.${DOMAIN} --ip-address=10.110.1.105 --password='IPAPASS'

ipa hostgroup-add-member usernodes --hosts chead1
ipa hostgroup-add-member usernodes --hosts cnode01
ipa hostgroup-add-member usernodes --hosts cnode02
ipa hostgroup-add-member usernodes --hosts cnode03
ipa hostgroup-add-member usernodes --hosts cnode04
ipa hostgroup-add-member usernodes --hosts cnode05
# Reboot
echo "It is recommended to reboot the system now that IPA has been configured"
