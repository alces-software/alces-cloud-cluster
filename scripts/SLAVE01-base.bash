yum -y install chrony
cat << EOF > /etc/chrony.conf
server 10.110.1.100 iburst

driftfile /var/lib/chrony/drift
makestep 360 10
EOF
systemctl enable chronyd
systemctl start chronyd
