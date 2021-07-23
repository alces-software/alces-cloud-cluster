cat << EOF >> /root/.ssh/authorized_keys
ssh-rsa REPLACEME
EOF

rm -rf /etc/yum.repos.d/*
curl http://10.110.1.200/deployment/repo/cluster.repo > /etc/yum.repos.d/cluster.repo
yum clean all
