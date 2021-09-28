yum -y update 

cat << "EOF" > /etc/profile.d/flightcenter.sh
#Custom PS1 with client name
[ -f /etc/flightcentersupported ] && c=32 || c=31
if [ "$PS1" ]; then
  PS1="[\u@\h\[\e[1;${c}m\] [clustername-cloud1]\[\e[0m\] \W]\\$ "
fi
EOF

touch /etc/flightcentersupported

hostnamectl set-hostname cgw1.cloud1.pri.clustername.alces.network

# HTTP Server
yum -y install httpd

cat << EOF > /etc/httpd/conf.d/deployment.conf
<Directory /opt/flight/deployment/>
    Options Indexes MultiViews FollowSymlinks
    AllowOverride None
    Require all granted
    Order Allow,Deny
    Allow from 10.110.0.0/16
</Directory>
Alias /deployment /opt/flight/deployment/
EOF

systemctl enable httpd
systemctl start httpd

systemctl disable NetworkManager
systemctl mask NetworkManager
systemctl stop NetworkManager

touch /etc/cloud/cloud-init.disabled

systemctl disable cloud-init
systemctl disable cloud-config
systemctl disable cloud-final
systemctl disable cloud-init-local

# Install Azure CLI
## rpm --import https://packages.microsoft.com/keys/microsoft.asc
## cat << EOF > /etc/yum.repos.d/azure-cli.repo
## [azure-cli]
## name=Azure CLI
## baseurl=https://packages.microsoft.com/yumrepos/azure-cli
## enabled=1
## gpgcheck=1
## gpgkey=https://packages.microsoft.com/keys/microsoft.asc
## EOF
## yum install azure-cli

