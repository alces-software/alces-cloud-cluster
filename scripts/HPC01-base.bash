cat << EOF > /etc/security/limits.d/99-hpc.conf
* soft memlock unlimited
* hard memlock unlimited
EOF
